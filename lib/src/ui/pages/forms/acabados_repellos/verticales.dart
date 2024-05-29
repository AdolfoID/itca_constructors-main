import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:itca_construction/src/models/pdf_page.dart';
import 'package:itca_construction/src/ui/widgets/form_dropdown_widget.dart';
import 'package:itca_construction/src/ui/widgets/form_header.dart';
import 'package:itca_construction/src/utils/doubles_parse.dart';
import 'package:itca_construction/src/utils/string_to_decimal.dart';

import '../../../../models/mamposteria_bloque_result_model.dart';
import '../../../../models/result_data_for_pdf_model.dart';
import '../../../../models/result_model.dart';
import '../../../../providers/form_validators.dart';
import '../../../../providers/price_provider.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/form_title_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../pdf_preview_page.dart';

enum AcabadoType {
  afinado,
  repello,
}

class AcabadoSuperficiesVerticalespage extends StatefulWidget {
  final String title;
  final AcabadoType type;
  const AcabadoSuperficiesVerticalespage({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  State<AcabadoSuperficiesVerticalespage> createState() =>
      _AcabadoSuperficiesVerticalespageState();
}

class _AcabadoSuperficiesVerticalespageState
    extends State<AcabadoSuperficiesVerticalespage> with FormValidator {
  final formKey = GlobalKey<FormState>();
  final largoText = TextEditingController();
  final altoText = TextEditingController();

  final desperdicioText = TextEditingController();
  String proporcion = '';

  @override
  void initState() {
    super.initState();
    _reiniciarTodo();
    proporcion = proporciones.first;
  }

  List<String> get proporciones => [
        "1:3","1:4"
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
              image: "assets/misc/Acabados_Mesa de trabajo 1.png",
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

  ResultDataForPdfModel calcRepello({
    required Decimal areaCalculo,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];

 if (proporcion == "1:3") {
      // Proporción 1:5
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO PORTLAND TIPO 1",
        unidad: "BOLSA",
        constante: 0.250.d,
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
        constante: 0.026.d,
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
         constante: 52.000.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );
      } else {
      // Proporciones 1:4
      materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO PORTLAND TIPO 1",
        unidad: "BOLSA",
        constante: 0.200.d,
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
        constante: 0.023.d,
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
        constante: 46.000.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.agua,
        ),
      ),
    );

    }
    final materiales = ResultDataForPdfModel(
      items: materialsItems,
      title: title.toUpperCase(),
      titleBackColor: Colors.blue,
    );
    return materiales;
  }
  ResultDataForPdfModel calcAfinado({
    required Decimal areaCalculo,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO ALBAÑILERÍA TIPO S",
        unidad: "BOLSA",
        constante: 0.037.d,
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
        constante: 0.002.d,
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
        constante: 5.50.d,
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
  _calcular(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final largo = largoText.text.toRegionalDouble();
      final altura = altoText.text.toRegionalDouble();
      final area = largo * altura;
      final desperdicio =
          (desperdicioText.text.toRegionalDouble() / 100.0.d).toDecimal();
      ResultDataForPdfModel materiales;
      switch (widget.type) {
        case AcabadoType.afinado:
          materiales = calcAfinado(
            areaCalculo: area,
            desperdicio: desperdicio,
          );
          break;
        case AcabadoType.repello:
          materiales = calcRepello(
            areaCalculo: area,
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
   pdfTitle:  widget.title,
          ),
        ),
      );
    }
  }
  void _reiniciarTodo() {
    largoText.clear();
    altoText.clear();
    desperdicioText.text = "3";
  }
}