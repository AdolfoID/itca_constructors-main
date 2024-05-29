import 'package:flutter/material.dart';
import 'package:itca_construction/src/ui/pages/forms/paredes/ladrillo_page.dart';

import '../../widgets/action_widget.dart';
import '../forms/paredes/bloque_15_20_40.dart';

class ParedesPage extends StatelessWidget {
  const ParedesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paredes"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ActionWidget(
            title: "Pared de bloque de 15x20x40",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: "assets/misc/Pared_Mesa de trabajo 1.png",
            onTap: () => _openParedDeBloque(context),
          ),
          ActionWidget(
            title: "Pared de mamposteria con nervadura",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: "assets/misc/Pared_Mesa de trabajo 1.png",
            onTap: () => _openParedMamposteria(context),
          ),
        ],
      ),
    );
  }

  void _openParedDeBloque(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ParedesBloque152040(),
      ),
    );
  }

  void _openParedMamposteria(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MamposteriaLadrillosPage(),
      ),
    );
  }
}
