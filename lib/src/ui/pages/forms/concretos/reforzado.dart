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

enum ConcretoType {
  resistencia210,
  resistencia170,
  resistencia280,
}

class ContretoReforzadoPage extends StatefulWidget {
  final String title;
  final ConcretoType type;
  const ContretoReforzadoPage({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  State<ContretoReforzadoPage> createState() => _ContretoReforzadoPageState();
}

class _ContretoReforzadoPageState extends State<ContretoReforzadoPage>
    with FormValidator {
  final formKey = GlobalKey<FormState>();
  final largoText = TextEditingController();
  final altoText = TextEditingController();
  final baseText = TextEditingController();

  final desperdicioText = TextEditingController();
  String proporcion = '';

  @override
  void initState() {
    super.initState();
    _reiniciarTodo();
    proporcion = proporciones.first;
  }

  List<String> get proporciones => [
        if (widget.type == ConcretoType.resistencia210) "1:2:2",
        if (widget.type == ConcretoType.resistencia170) "1:2:3",
        if (widget.type == ConcretoType.resistencia280) "1:1.5:2",
      ];

  String get title => widget.title;

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
              image: "assets/misc/Concreto_Mesa de trabajo 1.png",
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
                          label: "Base",
                          controller: baseText,
                        ),
                        TextFieldWidget(
                          label: "Altura",
                          controller: altoText,
                        ),
                        TextFieldWidget(
                          label: "Largo",
                          controller: largoText,
                        ),
                        TextFieldWidget(
                          label: "Desperdicio",
                          controller: desperdicioText,
                          suffixWidget: const Text("%"),
                        ),
                      ],
                    )),
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

  ResultDataForPdfModel calcResistencia210({
    required Decimal areaCalculo,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO TIPO GU",
        unidad: "BOLSA",
        constante: 9.8.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoTipoGU,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "ARENA",
        unidad: "m3",
        constante: 0.55.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.arena,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "GRAVA",
        unidad: "m3",
        constante: 0.55.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.grava,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "AGUA",
        unidad: "L",
        constante: 227.0.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final materiales = ResultDataForPdfModel(
      items: materialsItems,
      title: title.toUpperCase(),
      titleBackColor: Colors.blue,
    );

    return materiales;
  }

  ResultDataForPdfModel calcResistencia170({
    required Decimal areaCalculo,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO TIPO GU",
        unidad: "BOLSA",
        constante: 11.30.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoTipoGU,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "ARENA",
        unidad: "m3",
        constante: 0.48.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.arena,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "GRAVA",
        unidad: "m3",
        constante: 0.64.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.grava,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "AGUA",
        unidad: "L",
        constante: 221.0.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final materiales = ResultDataForPdfModel(
      items: materialsItems,
      title: title.toUpperCase(),
      titleBackColor: Colors.blue,
    );

    return materiales;
  }

  ResultDataForPdfModel calcResistencia280({
    required Decimal areaCalculo,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO TIPO GU",
        unidad: "BOLSA",
        constante: 18.48.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoTipoGU,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "ARENA",
        unidad: "m3",
        constante: 1.034.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.arena,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "GRAVA",
        unidad: "m3",
        constante: 1.562.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.grava,
        ),
      ),
    );
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "AGUA",
        unidad: "barril",
        constante: 475.0.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    final materiales = ResultDataForPdfModel(
      items: materialsItems,
      title: widget.title.toUpperCase(),
      titleBackColor: Colors.blue,
    );

    return materiales;
  }

  _calcular(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final largo = largoText.text.toRegionalDouble();
      final altura = altoText.text.toRegionalDouble();
      final base = baseText.text.toRegionalDouble();
      final volumen = base * largo * altura;

      final desperdicio =
          (desperdicioText.text.toRegionalDouble() / 100.0.d).toDecimal();

      ResultDataForPdfModel materiales;
      switch (widget.type) {
        case ConcretoType.resistencia210:
          materiales = calcResistencia210(
            areaCalculo: volumen,
            desperdicio: desperdicio,
          );
          break;

        case ConcretoType.resistencia170:
          materiales = calcResistencia170(
            areaCalculo: volumen,
            desperdicio: desperdicio,
          );
          break;
        case ConcretoType.resistencia280:
          materiales = calcResistencia280(
            areaCalculo: volumen,
            desperdicio: desperdicio,
          );
          break;
      }

      final results = [
        PdfPageData(results: [
          materiales,
        ])
      ];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfPreviewPage(
            results: results,
            pdfTitle: widget.title,
          ),
        ),
      );
    }
  }

  void _reiniciarTodo() {
    largoText.clear();
    altoText.clear();
    baseText.text = "1";
    desperdicioText.text = "10";
  }
}
