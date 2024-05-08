import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:itca_construction/src/models/pdf_page.dart';
import 'package:itca_construction/src/ui/widgets/form_header.dart';
import 'package:itca_construction/src/utils/doubles_parse.dart';
import 'package:itca_construction/src/utils/string_to_decimal.dart';

import '../../../../models/mamposteria_bloque_result_model.dart';
import '../../../../models/result_data_for_pdf_model.dart';
import '../../../../models/result_model.dart';
import '../../../../providers/form_validators.dart';
import '../../../../providers/price_provider.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/form_dropdown_widget.dart';
import '../../../widgets/form_title_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../pdf_preview_page.dart';

enum BloqueSize {
  s10x20x40,
  s15x20x40,
  s20x20x40,
}

class MamposteriaBloquesPage extends StatefulWidget {
  final BloqueSize bloqueSize;
  const MamposteriaBloquesPage({
    super.key,
    required this.bloqueSize,
  });

  @override
  State<MamposteriaBloquesPage> createState() => _MamposteriaBloquesPageState();
}

class _MamposteriaBloquesPageState extends State<MamposteriaBloquesPage>
    with FormValidator {
  BloqueSize get bloqueSize => widget.bloqueSize;

  final formKey = GlobalKey<FormState>();
  final largoText = TextEditingController();
  final altoText = TextEditingController();
  //final ladrillosDesperdicioText = TextEditingController();
  final morteroText = TextEditingController();
  final puertasCantidad = TextEditingController();
  final anchoPuerta = TextEditingController();
  final altoPuerta = TextEditingController();
  final cantidadVentana = TextEditingController();
  final anchoVentana = TextEditingController();
  final altoVentana = TextEditingController();
  final bloqueSoleraText = TextEditingController();
  String proporcion = '';

  @override
  void initState() {
    super.initState();
    _reiniciarTodo();
    proporcion = proporciones.first;
  }

  List<String> get proporciones => [
        if (bloqueSize == BloqueSize.s20x20x40 ||
            bloqueSize == BloqueSize.s10x20x40)
          "1:6",
        if (bloqueSize == BloqueSize.s15x20x40 ||
            bloqueSize == BloqueSize.s10x20x40)
          "1:7",
        if (bloqueSize == BloqueSize.s20x20x40) "1:8",
      ];

  String get title {
    switch (bloqueSize) {
      case BloqueSize.s10x20x40:
        return "Mamposteria bloque de 10x20x40";
      case BloqueSize.s15x20x40:
        return "Mamposteria bloque de 15x20x40";
      case BloqueSize.s20x20x40:
        return "Mamposteria bloque de 20x20x40";
    }
  }

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
              image: "assets/misc/Mamposteria_Mesa de trabajo 1.png",
              title: title,
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
                        controller: altoText,
                      ),
                      TextFieldWidget(
                        label: "Soleras",
                        controller: bloqueSoleraText,
                      ),
                      TextFieldWidget(
                        label: "Desperdicio",
                        controller: morteroText,
                        suffixWidget: const Text("%"),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      FormDropdownWidget(
                       
                         title: "Proporción",
                        items: proporciones,
                        value: proporcion,
                        onChanged: (value) {
                          setState(() => proporcion = value!);
                        },
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

  ResultDataForPdfModel materialesBloque15x20x40({
    required Decimal areaCalculo,
    required Decimal desperdicio,
    required Decimal solera,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "BLOQUES 15X20X40",
        unidad: "UN",
        constante: 12.50.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.bloquesx15x20x40,
        ),
      ),
    );
    materialsItems.add(
      SimpleValueResultModel(
        descripcion: "Dados 15X20X40",
        unidad: "UN",
        constante: 25.75.d,
        materialValor: dadosMaterial,
        precioUnitario: priceProvider.getPrice(
          PriceItem.dadosx15x20x40,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "SOLERA 15X20X40",
        unidad: "UNIDAD",
        constante: 12.50.d,
        materialValor: solera,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoAlbanileriaTipoS,
        ),
      ),
    );

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO ALBAÑILERÍA TIPO S",
        unidad: "BOLSA",
        constante: 0.32.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoAlbanileriaTipoS,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "ARENA",
        unidad: "m3",
        constante: 0.054.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.arena,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "AGUA",
        unidad: "L",
        constante: 10.00.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final materiales = ResultDataForPdfModel(
      items: materialsItems,
      title: "MATERIALES DE BLOQUE 10X20X40",
      titleBackColor: Colors.blue,
    );

    return materiales;
  }

  Decimal get dadosMaterial {
    final cantidadVentanas = cantidadVentana.text.toRegionalDouble();
    final cantidadPuertas = puertasCantidad.text.toRegionalDouble();
    final altoVentanas = altoVentana.text.toRegionalDouble();
    final altoPuertas = altoPuerta.text.toRegionalDouble();
    final alto = altoText.text.toRegionalDouble();

    final dados = (alto / 0.2.d).toDecimal() +
        ((cantidadPuertas * altoPuertas) / 0.2.d).toDecimal() +
        ((cantidadVentanas * altoVentanas) / 0.2.d).toDecimal() *
            (0.03.d + Decimal.one);

    return dados;
  }

  ResultDataForPdfModel materialesBloque20x20x40({
    required Decimal areaCalculo,
    required Decimal desperdicio,
    required Decimal solera,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];

    // Materiales generales
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "BLOQUES 20X20X40",
        unidad: "UN",
        constante: 12.50.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.bloquesx20x20x40,
        ),
      ),
    );
    materialsItems.add(
      SimpleValueResultModel(
        descripcion: "Dados 20X20X40",
        unidad: "UN",
        constante: 25.75.d,
        materialValor: dadosMaterial,
        precioUnitario: priceProvider.getPrice(
          PriceItem.dadosx20x20x40,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "SOLERA 20X20X40",
        unidad: "UNIDAD",
        constante: 12.50.d,
        materialValor: solera,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoAlbanileriaTipoS,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO ALBAÑILERÍA TIPO S",
        unidad: "BOLSA",
        constante: 0.42.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoAlbanileriaTipoS,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "ARENA",
        unidad: "m3",
        constante: 0.072.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.arena,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "AGUA",
        unidad: "L",
        constante: 12.00.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final materiales = ResultDataForPdfModel(
      items: materialsItems,
      title: "MATERIALES DE BLOQUE 20X20X40",
      titleBackColor: Colors.blue,
    );

    return materiales;
  }

  ResultDataForPdfModel materialesBloque10x20x40({
    required Decimal areaCalculo,
    required Decimal desperdicio,
    required Decimal solera,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "BLOQUES 10X20X40",
        unidad: "UN",
        constante: 12.50.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.bloquesx10x20x40,
        ),
      ),
    );
    materialsItems.add(
      SimpleValueResultModel(
        descripcion: "Dados 10X20X40",
        unidad: "UN",
        constante: 25.75.d,
        materialValor: dadosMaterial,
        precioUnitario: priceProvider.getPrice(
          PriceItem.dadosx10x20x40,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "SOLERA 10X20X40",
        unidad: "UNIDAD",
        constante: 12.50.d,
        materialValor: solera,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoAlbanileriaTipoS,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO ALBAÑILERÍA TIPO S",
        unidad: "BOLSA",
        constante: 0.25.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoAlbanileriaTipoS,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "ARENA",
        unidad: "m3",
        constante: 0.04.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.arena,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "AGUA",
        unidad: "L",
        constante: 8.00.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final materiales = ResultDataForPdfModel(
      items: materialsItems,
      title: "MATERIALES DE BLOQUE 10X20X40",
      titleBackColor: Colors.blue,
    );

    return materiales;
  }

  _calcular(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final bloqueSolera = bloqueSoleraText.text.toRegionalDouble();
      final largo = largoText.text.toRegionalDouble();
      final bloques = largoText.text.toRegionalDouble() *
          bloqueSoleraText.text.toRegionalDouble() *
          0.2.d;
      final area =
          largoText.text.toRegionalDouble() * altoText.text.toRegionalDouble();
      final puertaArea = altoPuerta.text.toRegionalDouble() *
          anchoPuerta.text.toRegionalDouble() *
          puertasCantidad.text.toRegionalDouble();
      final ventanaArea = altoVentana.text.toRegionalDouble() *
          anchoVentana.text.toRegionalDouble() *
          cantidadVentana.text.toRegionalDouble();
      final desperdicio = morteroText.text.toRegionalDouble() / 100.0.d;

      final totalM2 = bloques + puertaArea + ventanaArea;
      final areaCalculo = area - totalM2;

      final solera = bloqueSolera * (largo * 0.2.d);
      ResultDataForPdfModel materiales;

      switch (bloqueSize) {
        case BloqueSize.s10x20x40:
          materiales = materialesBloque10x20x40(
            areaCalculo: areaCalculo,
            desperdicio: desperdicio.toDecimal(),
            solera: solera,
          );
        case BloqueSize.s15x20x40:
          materiales = materialesBloque15x20x40(
            areaCalculo: areaCalculo,
            desperdicio: desperdicio.toDecimal(),
            solera: solera,
          );
        case BloqueSize.s20x20x40:
          materiales = materialesBloque20x20x40(
            areaCalculo: areaCalculo,
            desperdicio: desperdicio.toDecimal(),
            solera: solera,
          );
      }

      final results = [
        PdfPageData(results: [
          materiales,
        ]),
      ];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfPreviewPage(
            results: results,
          pdfTitle:  title,
          ),
        ),
      );
    }
  }

  void _reiniciarTodo() {
    largoText.clear();
    altoText.clear();
    //ladrillosDesperdicioText.text = "10";
    morteroText.text = "3";
    //puertas
    puertasCantidad.text = "1";
    anchoPuerta.text = "0.8";
    altoPuerta.text = "2.1";
    // ventanas
    cantidadVentana.text = "0";
    anchoVentana.text = "0";
    altoVentana.text = "0";
    bloqueSoleraText.text = "2";
  }
}
