import 'package:flutter/material.dart';
import 'package:itca_construction/src/ui/pages/forms/mamposteria/bloques_page.dart';
import 'package:itca_construction/src/ui/pages/forms/mamposteria/piedra_page.dart';

import '../../widgets/action_widget.dart';
import '../forms/mamposteria/ladrillos_page.dart';

class MamposteriaPage extends StatelessWidget {
  const MamposteriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    const image = "assets/misc/Mamposteria_Mesa de trabajo 1.png";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mamposteria"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ActionWidget(
            title: "Muros de mamposteria de piedra",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 0),
          ),
          ActionWidget(
            title: "Mamposteria de ladrillos puesto de lazo",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 1),
          ),
          ActionWidget(
            title: "Mamposteria de ladrillos puesto de canto",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 2),
          ),
          ActionWidget(
            title: "Mamposteria ladrillos puesto de trinchera",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 3),
          ),
          ActionWidget(
            title: "Mamposteria de bloques 10x20x40",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 4),
          ),
          ActionWidget(
            title: "Mamposteria de bloques 15x20x40",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 5),
          ),
          ActionWidget(
            title: "Mamposteria de bloques 20x20x40",
            subtitle: "Cantidad de piedra, cemento, grava, arena y agua",
            image: image,
            onTap: () => _openPage(context, 6),
          ),
        ],
      ),
    );
  }

  _openPage(BuildContext context, int i) {
    switch (i) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MamposteriaPiedraPage(
              title: "Muros de mamposteria de piedra",
            ),
          ),
        );
        break;
      case 1:
        const page = MamposteriaLadrillosPage(
          ladrillosType: LadrillosType.puestoDeLazo,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
        break;
      case 2:
        const page = MamposteriaLadrillosPage(
          ladrillosType: LadrillosType.lazoDeCanto,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
        break;
      case 3:
         const page = MamposteriaLadrillosPage(
          ladrillosType: LadrillosType.trinchera,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MamposteriaBloquesPage(
              bloqueSize: BloqueSize.s10x20x40,
            ),
          ),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MamposteriaBloquesPage(
              bloqueSize: BloqueSize.s15x20x40,
            ),
          ),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MamposteriaBloquesPage(
              bloqueSize: BloqueSize.s20x20x40,
            ),
          ),
        );
        break;
    }
  }
}
