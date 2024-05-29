import 'package:flutter/material.dart';
import '../../widgets/action_widget.dart';
import 'package:itca_construction/src/ui/pages/forms/excavaciones/excavaciones.dart';
import ''; // Asegúrate de tener esta importación correcta.

class ExcavacionPage extends StatelessWidget {
  const ExcavacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    const image = "assets/misc/excavacion.png";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Excavación"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ActionWidget(
            title: "Excavación",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 0),
          ),
        ],
      ),
    );
  }

  

  void _openPage(BuildContext context, int i) {
    switch (i) {
      case 0:
        final page = ExcavacionDetailPage(
          title: "Excavaciones",
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
        break;
      default:
    }
  }
}
