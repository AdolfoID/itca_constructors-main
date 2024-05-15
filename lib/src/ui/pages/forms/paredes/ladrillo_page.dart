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

 
class MamposteriaLadrillosPage extends StatefulWidget {
  
  const MamposteriaLadrillosPage({
    super.key,
 
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

  List<String> get proporciones => [ "1:5",
       
      ];

  String get title {
    
        return "Pared de mamposteria de ladrillo de obra puesto de lazo";
   
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
  }) {
    final priceProvider = PriceProvider.instance;
    final materialsItems = <ResultItem>[];
    // Materiales generales
    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "Ladrillos",
        unidad: "UN",
        constante: 46.0.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.piedra,
        ),
      ),
    );

    materialsItems.add(
      MamposteriaBloqueResultModel(
        descripcion: "CEMENTO PORTLAND TIPO 1",
        unidad: "BOLSA",
        constante: 0.13.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoTipo1,
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
        descripcion: "CEMENTO PORTLAND TIPO 1",
        unidad: "BOLSA",
        constante: 0.065.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoTipo1,
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
        descripcion: "CEMENTO PORTLAND TIPO 1",
        unidad: "BOLSA",
        constante: 0.385.d,
        materialValor: areaCalculo,
        desperdicioLadrillos: desperdicio,
        precioUnitario: priceProvider.getPrice(
          PriceItem.cementoTipo1,
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
      
      final area =  largo * altura;

      final desperdicio =
          (desperdicioText.text.toRegionalDouble() / 100.0.d).toDecimal();

      ResultDataForPdfModel? materiales;
 
          materiales = calc(
            areaCalculo: area,
            desperdicio: desperdicio,
          );
  
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
