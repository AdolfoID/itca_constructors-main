import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

import 'package:itca_construction/src/ui/widgets/form_header.dart';
import 'package:itca_construction/src/utils/string_to_decimal.dart'; 
import '../../../widgets/action_button.dart';
import '../../../widgets/form_title_widget.dart';
import '../../../widgets/text_field_widget.dart';


class ExcavacionDetailPage extends StatefulWidget {
  final String title;

  const ExcavacionDetailPage({
    super.key,
    required this.title,
  });

  @override
  State<ExcavacionDetailPage> createState() => _ExcavacionDetailPageState();
}

class _ExcavacionDetailPageState extends State<ExcavacionDetailPage> {
  final formKey = GlobalKey<FormState>();
  final anchoText = TextEditingController();
  final profundidadText = TextEditingController();
  final largoText = TextEditingController();

  Decimal _volumen = Decimal.zero;

  @override
  void initState() {
    super.initState();
    _reiniciarTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
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
            const FormTitleWidget(
              title: "Parámetros de la excavación",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFieldWidget(
                    label: "Ancho (m)",
                    controller: anchoText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el ancho';
                      }
                      return null;
                    },
                  ),
                  TextFieldWidget(
                    label: "Profundidad (m)",
                    controller: profundidadText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la profundidad';
                      }
                      return null;
                    },
                  ),
                  TextFieldWidget(
                    label: "Largo (m)",
                    controller: largoText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el largo';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ActionButton(
                    child: const Text("Calcular"),
                    onPressed: _calcular,
                  ),
                  const SizedBox(height: 25),
                 Text(
                        'Volumen de Excavación: $_volumen m³',
                        style: const TextStyle(
                        fontSize: 22, // Tamaño de la fuente aumentado
                        fontWeight: FontWeight.bold, // Texto en negrita
                        color: Color.fromARGB(255, 24, 20, 15), // Color del texto
                        letterSpacing: 1.5, // Espaciado entre letras
                         
                          ),
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calcular() {
    if (formKey.currentState!.validate()) {
      final ancho = anchoText.text.toDecimal();
      final profundidad = profundidadText.text.toDecimal();
      final largo = largoText.text.toDecimal();
      final volumen = ancho * profundidad * largo;

      setState(() {
        _volumen = volumen;
      });
    }
  }

  void _reiniciarTodo() {
    anchoText.clear();
    profundidadText.clear();
    largoText.clear();
    setState(() {
      _volumen = Decimal.zero;
    });
  }
}
