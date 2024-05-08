import 'package:flutter/material.dart';
import 'package:itca_construction/src/ui/pages/forms/pisos/pisos_concreto.dart';
import 'package:itca_construction/src/ui/pages/forms/pisos/pisos_la_concreto.dart';

import '../../widgets/action_widget.dart';

class PisosPage extends StatelessWidget {
  const PisosPage({super.key});
  @override
  Widget build(BuildContext context) {
    const image = "assets/misc/Pisos_Mesa de trabajo 1.png";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pisos"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ActionWidget(
            title: "Piso de concreto simple",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 0),
          ),
          ActionWidget(
            title: "Piso lad de cemento",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 1),
          )
        ],
      ),
    );
  }

  _openPage(BuildContext context, int i) {
    if(i == 0){
      const page = PisosConcretoPage(title: "Piso de concreto simple");
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }else{
      const page = PisosLadConcretoPage(title: "Piso lad de cemento");
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }
  }
}
