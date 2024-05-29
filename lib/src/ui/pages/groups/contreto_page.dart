import 'package:flutter/material.dart';
import 'package:itca_construction/src/ui/pages/forms/concretos/losa_reforzada.dart';
import 'package:itca_construction/src/ui/pages/forms/concretos/reforzado.dart';

import '../../widgets/action_widget.dart';

class ConcretoPage extends StatelessWidget {
  const ConcretoPage({super.key});
  @override
  Widget build(BuildContext context) {
    const image = "assets/misc/Concreto_Mesa de trabajo 1.png";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Concreto"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ActionWidget(
            title: "Concreto resistencia 170",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 0),
          ),
          ActionWidget(
            title: "Concreto resistencia 210",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 1),
          ),
          ActionWidget(
            title: "Concreto resistencia 280",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 2),
          ),
          ActionWidget(
            title: "Losa de concreto reforzado",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 3),
          ),
          ActionWidget(
            title: "Zapata aislada",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 4),
          ),
          ActionWidget(
            title: "Zapata corrida",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 5),
          ),
        ],
      ),
    );
  }

  _openPage(BuildContext context, int i) {
    switch (i) {
      case 0:
        const page = ContretoReforzadoPage(
          title: "Concreto resistencia 170",
          type: ConcretoType.resistencia170,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );

        break;
      case 1:
        const page = ContretoReforzadoPage(
          title: "Concreto resistencia 210",
          type: ConcretoType.resistencia210,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );

        break;
      case 2:
        const page = ContretoReforzadoPage(
          title: "Concreto resistencia 280",
          type: ConcretoType.resistencia280,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );

        break;
      case 3:
        const page = LosaReforzadaPage(
          title: "Losa de concreto reforzado",
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );

        break;
      case 4:
        const page = LosaReforzadaPage(
          title: "Zapata Aislada",
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );

        break;
      case 5:
        const page = LosaReforzadaPage(
          title: "Zapata corrida",
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
