import 'package:flutter/material.dart';
import 'package:itca_construction/src/ui/pages/forms/acabados_repellos/repello_cuadrados.dart';

import '../../widgets/action_widget.dart';
import '../forms/acabados_repellos/verticales.dart';

class AcabadosPage extends StatelessWidget {
  const AcabadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    const image = "assets/misc/Acabados_Mesa de trabajo 1.png";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acabados"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ActionWidget(
            title: "Repello de superficies Verticales",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 0),
          ),
          ActionWidget(
            title: "Repello de cuadrados",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 1),
          ),
          ActionWidget(
            title: "Afinado de superficies Verticales",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 2),
          ),
          ActionWidget(
            title: "Afinado de cuadrados",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 3),
          ),
        ],
      ),
    );
  }

  _openPage(BuildContext context, int i) {
    switch (i) {
      case 0:
        const page = AcabadoSuperficiesVerticalespage(
          title: "Repello de superficies Verticales",
          type: AcabadoType.repello,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        break;
      case 1:
        const page = RepelloCuadradosPage(
          title: "Repello de cuadrados",
          type: AcabadoType.repello,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        break;

      case 2:
        const page = AcabadoSuperficiesVerticalespage(
          title: "Afinado de superficies Verticales",
          type: AcabadoType.afinado,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        break;
      case 3:
         const page = RepelloCuadradosPage(
          title: "Afinado de cuadrados",
          type: AcabadoType.afinado,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      
        break;
    }
  }
}
