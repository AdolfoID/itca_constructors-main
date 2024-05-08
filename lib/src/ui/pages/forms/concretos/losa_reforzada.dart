import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:itca_construction/src/models/pdf_page.dart';
import 'package:itca_construction/src/ui/widgets/form_header.dart';
import 'package:itca_construction/src/utils/doubles_parse.dart';
import 'package:itca_construction/src/utils/string_to_decimal.dart';

import '../../../../models/mamposteria_bloque_result_model.dart';
import '../../../../models/result_data_for_pdf_model.dart';
import '../../../../models/result_model.dart';
import '../../../../models/varillas_model.dart';
import '../../../../providers/form_validators.dart';
import '../../../../providers/price_provider.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/form_dropdown_widget.dart';
import '../../../widgets/form_title_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../pdf_preview_page.dart';

class LosaReforzadaPage extends StatefulWidget {
  final String title;
  const LosaReforzadaPage({
    super.key,
    required this.title,
  });

  @override
  State<LosaReforzadaPage> createState() => _LosaReforzadaPageState();
}

class _LosaReforzadaPageState extends State<LosaReforzadaPage> with FormValidator {
  final formKey = GlobalKey<FormState>();
  final largoText = TextEditingController();
  final anchoText = TextEditingController();
  final anchoVarillasText = TextEditingController();
  final largoVarillasText = TextEditingController();
  final espesorText = TextEditingController();
  final desperdicioText = TextEditingController();
  String proporcion = '';

  @override
  void initState() {
    super.initState();
    _reiniciarTodo();
    proporcion = proporciones.first;
  }

  List<String> get proporciones => [
        "1:2:2",
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
                          label: "Espesor",
                          controller: espesorText,
                        ),
                        TextFieldWidget(
                          label: "Ancho",
                          controller: anchoText,
                        ),
                        TextFieldWidget(
                          label: "Largo",
                          controller: largoText,
                        ),
                        TextFieldWidget(
                          label: "Ancho de varillas",
                          controller: anchoVarillasText,
                          suffixWidget: const Text("m"),
                        ),
                        TextFieldWidget(
                          label: "Largo de varillas",
                          controller: largoVarillasText,
                          suffixWidget: const Text("m"),
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

  ResultDataForPdfModel calc({
    required Decimal areaCalculo,
    required Decimal desperdicio,
    required Decimal totalVarillas,
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

  List<ResultDataForPdfModel> calcVarillas({
    required Decimal areaCalculo,
    required Decimal desperdicio,
    required Decimal totalVarillas,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    final materialsItems2 = <ResultItem>[];
    // Materiales generales

    materialsItems.add(
      VarillasResultModel(
        descripcion: "ACERO 1/4\"",
        unidad: "qq",
        constante: 30.0.d,
        materialValor: totalVarillas,
        precioUnitario: priceProvider.getPrice(
          PriceItem.acero1_4,
        ),
      ),
    );
    materialsItems.add(
      VarillasResultModel(
        descripcion: "ACERO 3/8\"",
        unidad: "qq",
        constante: 13.60.d,
        materialValor: totalVarillas,
        precioUnitario: priceProvider.getPrice(
          PriceItem.acero3_8,
        ),
      ),
    );

    materialsItems.add(
      VarillasResultModel(
        descripcion: "ACERO 1/2\"",
        unidad: "qq",
        constante: 8.50.d,
        materialValor: totalVarillas,
        precioUnitario: priceProvider.getPrice(
          PriceItem.acero1_2,
        ),
      ),
    );
    materialsItems2.add(
      VarillasResultModel(
        descripcion: "ACERO 1/2\"",
        unidad: "qq",
        constante: 8.50.d,
        materialValor: totalVarillas,
        precioUnitario: priceProvider.getPrice(
          PriceItem.acero1_2,
        ),
      ),
    );
    materialsItems2.add(
      VarillasResultModel(
        descripcion: "ACERO 5/8\"",
        unidad: "qq",
        constante: 4.87.d,
        materialValor: totalVarillas,
        precioUnitario: priceProvider.getPrice(
          PriceItem.acero5_8,
        ),
      ),
    );

    materialsItems2.add(
      VarillasResultModel(
        descripcion: "ACERO 3/4\"",
        unidad: "qq",
        constante: 3.40.d,
        materialValor: totalVarillas,
        precioUnitario: priceProvider.getPrice(
          PriceItem.acero3_4,
        ),
      ),
    );
    materialsItems2.add(
      VarillasResultModel(
        descripcion: "ACERO 7/8\"",
        unidad: "qq",
        constante: 2.50.d,
        materialValor: totalVarillas,
        precioUnitario: priceProvider.getPrice(
          PriceItem.acero7_8,
        ),
      ),
    );

    materialsItems2.add(
      VarillasResultModel(
        descripcion: "ACERO 1\"",
        unidad: "qq",
        constante: 1.90.d,
        materialValor: totalVarillas,
        precioUnitario: priceProvider.getPrice(
          PriceItem.acero1,
        ),
      ),
    );

    final varillas = ResultDataForPdfModel(
      items: materialsItems + materialsItems2,
      title: "${title.toUpperCase()}(Varillas)",
      titleBackColor: Colors.blue,
    );

    return [varillas];
  }

  _calcular(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final largo = largoText.text.toRegionalDouble();
      final ancho = anchoText.text.toRegionalDouble();
      final espesor = espesorText.text.toRegionalDouble();
      final anchoVarillas = anchoVarillasText.text.toRegionalDouble();
      final largoVarillas = largoVarillasText.text.toRegionalDouble();
      final volumen = espesor * largo * ancho;

      final varillasAncho = (ancho / anchoVarillas).toDecimal();
      final varillasLargo = (largo / largoVarillas).toDouble();

      final anchoVarillaTotal = varillasAncho * ancho;
      final largoVarillaTotal = (varillasLargo.d * largo);
      final desperdicio =
          (desperdicioText.text.toRegionalDouble() / 100.0.d).toDecimal();

      final totalVarillas =
          ((anchoVarillaTotal + largoVarillaTotal) / 6.0.d).toDecimal() *
              (0.06.d + 1.0.d);
      final varillas = calcVarillas(
        areaCalculo: volumen,
        desperdicio: desperdicio,
        totalVarillas: totalVarillas,
      );
      final page1 = [
        calc(
          areaCalculo: volumen,
          desperdicio: desperdicio,
          totalVarillas: totalVarillas,
        ),
      ];

      final results = [
        PdfPageData(results: page1),
        PdfPageData(results: varillas),
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
    anchoText.clear();
    anchoVarillasText.text = "0.1";
    largoVarillasText.text = "0.12";
    espesorText.text = "0.150";
    desperdicioText.text = "3";
  }
}
