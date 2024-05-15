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

enum LadrillosType {
  ladoDeCanto,
  lazoDeCanto,
  trinchera,
}

class MamposteriaLadrillosPage extends StatefulWidget {
  final LadrillosType ladrillosType;
  const MamposteriaLadrillosPage({
    super.key,
    required this.ladrillosType,
  });

  @override
  State<MamposteriaLadrillosPage> createState() =>
      _MamposteriaLadrillosPageState();
}

class _MamposteriaLadrillosPageState extends State<MamposteriaLadrillosPage>
    with FormValidator {
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
        //if (widget.ladrillosType == LadrillosType.ladoDeCanto) "1:3",
        if (widget.ladrillosType == LadrillosType.ladoDeCanto) "1:5",
        if (widget.ladrillosType == LadrillosType.trinchera ||
            widget.ladrillosType == LadrillosType.lazoDeCanto)
          "1:6",
      ];

  String get title {
    switch (widget.ladrillosType) {
      case LadrillosType.ladoDeCanto:
        return "Mampostería de ladrillos de lado de canto";
      case LadrillosType.trinchera:
        return "Mampostería de ladrillos de trinchera";
      case LadrillosType.lazoDeCanto:
        return "Mampostería de ladrillos de puesto de canto";
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

  ResultDataForPdfModel lazoDeCanto_1_6({
    required Decimal areaCalculo,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "Ladrillos",
        unidad: "UN",
        constante: 25.0.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.ladrilloBarroCocido,
        ),
      ),
    );

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO PORTLAND TIPO S",
        unidad: "BOLSA",
        constante: 0.065.d,
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
        constante: 40.0.d,
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

  ResultDataForPdfModel ladoDeCanto_1_5({
    required Decimal areaCalculo,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "Ladrillos",
        unidad: "UN",
        constante: 25.0.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.piedra,
        ),
      ),
    );

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO PORTLAND TIPO S",
        unidad: "BOLSA",
        constante: 0.065.d,
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
        constante: 0.009.d,
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
        constante: 15.0.d,
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

  ResultDataForPdfModel trinchera_1_6({
    required Decimal areaCalculo,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "Ladrillos",
        unidad: "UN",
        constante: 92.0.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.piedra,
        ),
      ),
    );

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO PORTLAND TIPO S",
        unidad: "BOLSA",
        constante: 0.385.d,
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
        constante: 0.066.d,
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
        constante: 12.0.d,
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

      ResultDataForPdfModel? materiales;
      switch (widget.ladrillosType) {
        case LadrillosType.lazoDeCanto:
          materiales = lazoDeCanto_1_6(
            areaCalculo: area,
            desperdicio: desperdicio,
          );

          break;
        case LadrillosType.trinchera:
          materiales = trinchera_1_6(
            areaCalculo: area,
            desperdicio: desperdicio,
          );
          break;
        case LadrillosType.ladoDeCanto:
          materiales = ladoDeCanto_1_5(
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
          pdfTitle:  title,
          ),
        ),
      );
    }
  }

  void _reiniciarTodo() {
    largoText.clear();
    altoText.clear();
    desperdicioText.text = "3";
    proporcion = proporciones.last;
  }
}
