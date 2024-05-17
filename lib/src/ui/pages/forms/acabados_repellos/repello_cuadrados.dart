import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:itca_construction/src/models/pdf_page.dart';
import 'package:itca_construction/src/ui/pages/forms/acabados_repellos/verticales.dart';
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

class RepelloCuadradosPage extends StatefulWidget {
  final String title;
  final AcabadoType type;
  const RepelloCuadradosPage({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  State<RepelloCuadradosPage> createState() => _RepelloCuadradosPageState();
}

class _RepelloCuadradosPageState extends State<RepelloCuadradosPage>
    with FormValidator {
  final formKey = GlobalKey<FormState>();
  final largoText = TextEditingController();
  final anchoText = TextEditingController();
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
        "1:5",
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
                        if (widget.type == AcabadoType.repello)
                          TextFieldWidget(
                            label: "Ancho",
                            controller: anchoText,
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
                        if (widget.type == AcabadoType.repello)
                          TextFieldWidget(
                            label: "Espesor",
                            controller: espesorText,
                            suffixWidget: const Text("cm"),
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
    required Decimal volumenCalculo,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO ALBAÑILERÍA TIPO S",
        unidad: "BOLSA",
        constante: 0.165.d,
        materialValor: volumenCalculo,
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
        constante: 0.024.d,
        materialValor: volumenCalculo,
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
        constante: 44.0.d,
        materialValor: volumenCalculo,
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

  ResultDataForPdfModel calcAfinado({
    required Decimal metrosLineales,
    required Decimal desperdicio,
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO ALBAÑILERÍA TIPO S",
        unidad: "BOLSA",
        constante: 0.0073.d,
        materialValor: metrosLineales,
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
        constante: 0.000410.d,
        materialValor: metrosLineales,
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
        constante: 1.1.d,
        materialValor: metrosLineales,
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
      final ancho = anchoText.text.toRegionalDouble();
      final espesor = espesorText.text.toRegionalDouble();
      final volumen = largo * ancho * (espesor / 100.0.d).toDecimal();
      final metrosLineales = largo;

      final desperdicio =
          (desperdicioText.text.toRegionalDouble() / 100.0.d).toDecimal();

      ResultDataForPdfModel materiales;
      if (widget.type == AcabadoType.repello) {
        materiales = calcRepello(
          volumenCalculo: volumen,
          desperdicio: desperdicio,
        );
      } else {
        materiales = calcAfinado(
          metrosLineales: metrosLineales,
          desperdicio: desperdicio,
        );
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
    anchoText.clear();
    desperdicioText.text = "3";
    espesorText.text = "2";
  }
}
