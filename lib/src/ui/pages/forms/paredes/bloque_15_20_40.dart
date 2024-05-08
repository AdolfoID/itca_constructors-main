import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:itca_construction/src/models/bloque_result_model.dart';
import 'package:itca_construction/src/models/pdf_page.dart';
import 'package:itca_construction/src/ui/widgets/form_header.dart';
import 'package:itca_construction/src/utils/doubles_parse.dart';

import '../../../../models/concreto_bloque_solera_result_model.dart';
import '../../../../models/concreto_celda_result_model.dart';
import '../../../../models/result_data_for_pdf_model.dart';
import '../../../../models/result_model.dart';
import '../../../../providers/form_validators.dart';
import '../../../../providers/price_provider.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/form_dropdown_widget.dart';
import '../../../widgets/form_title_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../pdf_preview_page.dart';

class ParedesBloque152040 extends StatefulWidget {
  const ParedesBloque152040({super.key});

  @override
  State<ParedesBloque152040> createState() => _ParedesBloque152040State();
}

class _ParedesBloque152040State extends State<ParedesBloque152040>
    with FormValidator {
  final formKey = GlobalKey<FormState>();
  final largoText = TextEditingController();
  final anchoText = TextEditingController();
  final ladrillosDesperdicioText = TextEditingController();
  final morteroText = TextEditingController();
  final puertasCantidad = TextEditingController();
  final anchoPuerta = TextEditingController();
  final altoPuerta = TextEditingController();
  final cantidadVentana = TextEditingController();
  final anchoVentana = TextEditingController();
  final altoVentana = TextEditingController();
  final bloqueSolera = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _reiniciarTodo,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            FormHeader(
              image: "assets/misc/Pared_Mesa de trabajo 1.png",
              title: "Pared de bloque de 15x20x40",
              clearForm: _reiniciarTodo,
            ),
            const FormTitleWidget(
              title: "Parámetros generales",
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        label: "Largo",
                        controller: largoText,
                      ),
                      TextFieldWidget(
                        label: "Alto",
                        controller: anchoText,
                      ),
                      TextFieldWidget(
                        label: "Soleras",
                        controller: bloqueSolera,
                      ),
                    ],
                  ),
                ),
                const FormTitleWidget(
                  title: "Puertas",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        label: "Cantidad",
                        controller: puertasCantidad,
                      ),
                      TextFieldWidget(
                        label: "Ancho",
                        controller: anchoPuerta,
                      ),
                      TextFieldWidget(
                        label: "Alto",
                        controller: altoPuerta,
                      ),
                    ],
                  ),
                ),
                const FormTitleWidget(
                  title: "Ventanas",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        label: "Cantidad",
                        controller: cantidadVentana,
                      ),
                      TextFieldWidget(
                        label: "Ancho",
                        controller: anchoVentana,
                      ),
                      TextFieldWidget(
                        label: "Alto",
                        controller: altoVentana,
                      ),
                    ],
                  ),
                ),
                const FormTitleWidget(
                  title: "Desperdicio",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        label: "Bloques",
                        controller: ladrillosDesperdicioText,
                        suffixWidget: const Text("%"),
                      ),
                      TextFieldWidget(
                        label: "Mortero",
                        controller: morteroText,
                        suffixWidget: const Text("%"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      FormDropdownWidget(
                       
                         title: "Proporción",
                        items: const [
                          "1:6",
                        ],
                        value: "1:6",
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ActionButton(
                        child: const Text("Calcular"),
                        onPressed: () => _calcular(context),
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ResultDataForPdfModel concretoCelda(
      {required Decimal areaCalculo, required Decimal desperdicioMortero}) {
    final priceProvider = PriceProvider.instance;
    final items = <ResultItem>[];

    items.add(ConcretoCeldaResultModel(
      descripcion: "CEMENTO TIPO GU",
      unidad: "BOLSA",
      constante: Decimal.parse("8.400"),
      materialValor: areaCalculo,
      desperdicioMortero: desperdicioMortero,
      precioUnitario: priceProvider.getPrice(
        PriceItem.cementoTipoGU,
      ),
    ));
    items.add(ConcretoCeldaResultModel(
      descripcion: "ARENA",
      unidad: "m3",
      constante: Decimal.parse("0.470"),
      materialValor: areaCalculo,
      desperdicioMortero: desperdicioMortero,
      precioUnitario: priceProvider.getPrice(
        PriceItem.cementoTipo1,
      ),
    ));
    items.add(ConcretoCeldaResultModel(
      descripcion: "GRAVA (CHISPA)",
      unidad: "m3",
      constante: Decimal.parse("0.710"),
      materialValor: areaCalculo,
      desperdicioMortero: desperdicioMortero,
      precioUnitario: priceProvider.getPrice(
        PriceItem.gravaChispa,
      ),
    ));

    items.add(
      ConcretoCeldaResultModel(
        descripcion: "AGUA",
        unidad: "L",
        constante: Decimal.parse("216.000"),
        materialValor: areaCalculo,
        desperdicioMortero: desperdicioMortero,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final concretoSolera = ResultDataForPdfModel(
      items: items,
      title: "MATERIALES DE CONCRETO CELDA @60CM",
      titleBackColor: Colors.blue,
    );
    return concretoSolera;
  }

  ResultDataForPdfModel concretoSolera(
      {required Decimal areaCalculo, required Decimal desperdicioMortero}) {
    final priceProvider = PriceProvider.instance;
    final items = <ResultItem>[];

    items.add(ConcretoCeldaResultModel(
      descripcion: "CEMENTO TIPO GU",
      unidad: "BOLSA",
      constante: Decimal.parse("8.400"),
      materialValor: areaCalculo,
      desperdicioMortero: desperdicioMortero,
      precioUnitario: priceProvider.getPrice(
        PriceItem.cementoTipoGU,
      ),
    ));
    items.add(ConcretoCeldaResultModel(
      descripcion: "ARENA",
      unidad: "m3",
      constante: Decimal.parse("0.470"),
      materialValor: areaCalculo,
      desperdicioMortero: desperdicioMortero,
      precioUnitario: priceProvider.getPrice(
        PriceItem.cementoTipo1,
      ),
    ));
    items.add(ConcretoCeldaResultModel(
      descripcion: "GRAVA (CHISPA)",
      unidad: "m3",
      constante: Decimal.parse("0.710"),
      materialValor: areaCalculo,
      desperdicioMortero: desperdicioMortero,
      precioUnitario: priceProvider.getPrice(
        PriceItem.gravaChispa,
      ),
    ));

    items.add(
      ConcretoCeldaResultModel(
        descripcion: "AGUA",
        unidad: "L",
        constante: Decimal.parse("216.000"),
        materialValor: areaCalculo,
        desperdicioMortero: desperdicioMortero,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final concretoSolera = ResultDataForPdfModel(
      items: items,
      title: "MATERIALES DE CONCRETO DE SOLERA",
      titleBackColor: Colors.blue,
    );
    return concretoSolera;
  }

  @override
  void initState() {
    _reiniciarTodo();
    super.initState();
  }

  ResultDataForPdfModel materialesGlobales(
      {required Decimal areaCalculo, required Decimal desperdicioLadrillos}) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales
    materialsItems.add(
      BloqueResultModel(
        descripcion: "BLOQUES 15X20X40",
        unidad: "UN",
        constante: Decimal.parse("12.50"),
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos,
        precioUnitario: priceProvider.getPrice(
          PriceItem.bloquesx15x20x40,
        ),
      ),
    );
    materialsItems.add(
      BloqueResultModel(
        descripcion: "CEMENTO ALBAÑILERÍA TIPO S",
        unidad: "BOLSA",
        constante: Decimal.parse("0.32"),
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoAlbanileriaTipoS,
        ),
      ),
    );
    materialsItems.add(
      BloqueResultModel(
        descripcion: "ARENA",
        unidad: "m3",
        constante: Decimal.parse("0.054"),
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos,
        precioUnitario: priceProvider.getPrice(
          PriceItem.arena,
        ),
      ),
    );
    materialsItems.add(
      BloqueResultModel(
        descripcion: "AGUA",
        unidad: "L",
        constante: Decimal.parse("10.00"),
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final materiales = ResultDataForPdfModel(
      items: materialsItems,
      title: "Materiales",
      titleBackColor: Colors.blue,
    );

    return materiales;
  }

  ResultDataForPdfModel pegamentoSolera(
      {required Decimal areaCalculo, required Decimal desperdicioLadrillos}) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales
    materialsItems.add(
      ConcretoBloqueSoleraResultModel(
        descripcion: "BLOQUES 15X20X40",
        unidad: "UN",
        constante: Decimal.parse("12.50"),
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos,
        precioUnitario: priceProvider.getPrice(
          PriceItem.bloques,
        ),
      ),
    );
    materialsItems.add(
      ConcretoBloqueSoleraResultModel(
        descripcion: "CEMENTO ALBAÑILERÍA TIPO S",
        unidad: "BOLSA",
        constante: Decimal.parse("0.32"),
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoAlbanileriaTipoS,
        ),
      ),
    );
    materialsItems.add(
      ConcretoBloqueSoleraResultModel(
        descripcion: "ARENA",
        unidad: "m3",
        constante: Decimal.parse("0.054"),
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos,
        precioUnitario: priceProvider.getPrice(
          PriceItem.arena,
        ),
      ),
    );
    materialsItems.add(
      ConcretoBloqueSoleraResultModel(
        descripcion: "AGUA",
        unidad: "L",
        constante: Decimal.parse("10.00"),
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final materialesSolera = ResultDataForPdfModel(
      items: materialsItems,
      title: "MATERIALES DE PEGAMENTO BSOLERA",
      titleBackColor: Colors.blue,
    );

    return materialesSolera;
  }

  _calcular(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final bloques = largoText.text.toRegionalDouble() *
          bloqueSolera.text.toRegionalDouble() *
          Decimal.parse("0.2");
      final area =
          largoText.text.toRegionalDouble() * anchoText.text.toRegionalDouble();
      final puertaArea = altoPuerta.text.toRegionalDouble() *
          anchoPuerta.text.toRegionalDouble() *
          puertasCantidad.text.toRegionalDouble();
      final ventanaArea = altoVentana.text.toRegionalDouble() *
          anchoVentana.text.toRegionalDouble() *
          cantidadVentana.text.toRegionalDouble();
      final desperdicioLadrillos =
          ladrillosDesperdicioText.text.toRegionalDouble() /
              Decimal.parse("100");
      final desperdicioMortero =
          morteroText.text.toRegionalDouble() / Decimal.parse("100");
      final totalM2 = bloques + puertaArea + ventanaArea;
      final areaCalculo = area - totalM2;

      //MATERIALES
      final materiales = materialesGlobales(
        areaCalculo: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos.toDecimal(),
      );

      //MATERIALES DE CONCRETO CELDA @60CM:
      final concretoCeldas = concretoCelda(
        areaCalculo: areaCalculo,
        desperdicioMortero: desperdicioMortero.toDecimal(),
      );

      //MATERIALES DE PEGAMENTO BSOLERA:
      final materialesPegamentoSolera = pegamentoSolera(
        areaCalculo: areaCalculo,
        desperdicioLadrillos: desperdicioLadrillos.toDecimal(),
      );

      //MATERIALES DE CONCRETO DE SOLERA:
      final materialesConcretoSolera = concretoSolera(
        areaCalculo: areaCalculo,
        desperdicioMortero: desperdicioMortero.toDecimal(),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfPreviewPage(
            results: [
              PdfPageData(results: [materiales, concretoCeldas]),
              PdfPageData(results: [
                materialesPegamentoSolera,
              ]),
              PdfPageData(results: [
                materialesConcretoSolera,
              ]),
            ],
            pdfTitle:  "Pared de bloque de 15x20x40",
          ),
        ),
      );
    }
  }

  void _reiniciarTodo() {
    largoText.clear();
    anchoText.clear();
    ladrillosDesperdicioText.text = "10";
    morteroText.text = "3";
    //puertas
    puertasCantidad.text = "1";
    anchoPuerta.text = "1";
    altoPuerta.text = "2.1";
    // ventanas
    cantidadVentana.text = "1";
    anchoVentana.text = "1.8";
    altoVentana.text = "1";
    bloqueSolera.text = "3";
  }
}
