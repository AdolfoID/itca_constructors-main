import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Acerca de'),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              const SizedBox(height: 20),
              Image.asset(
                "assets/misc/logoicon.png",
                height: 125,
              ),
              const SizedBox(height: 20),
              const Text(
                "Constru-Itca\n"
                "\n"
                "Herramienta de automatización de calculo de materiales\n"
                "Políticas de privacidad:\n"
                "\n"
                "Nos damos cuenta de que la privacidad de su información personal es importante, esta política\n"
                "describe qué información se puede recopilar cuando utilice nuestra aplicación móvil, como se\n"
                "utiliza esa información y como se mantiene dicha información, al mismo tiempo detallamos la\n"
                "propiedad de dicha aplicación y sus diversos requisitos.\n"
                "\n"
                "\n"
                "1. El desarrollo de esta aplicación es el resultado del proyecto de investigación de la Escuela\n"
                "Especializada en Ingeniería ITCA-FEPADE Regional San Miguel.\n"
                "2. Prohibida su reproducción total o parcial para fines comerciales\n"
                "3. Es de uso exclusivo para fines educativos o de uso personal\n"
                "4. Los resultados y las decisiones que se tomen a partir del uso de la aplicación son\n"
                "responsabilidad de los usuarios\n"
                "5. ITCA-FEPADE no se hace responsable por las decisiones tomadas por los usuarios o la mala\n"
                "operación al momento de usar la aplicación\n"
                "6. Propiedad Intelectual de ITCA-FEPADE.\n"
                "\n"
                "\n"
                "Investigadores\n"
                "Ing. Alonso Ulises Arias Guevara\n"
                "Tec. Benjamin Alessandro Ramírez\n",
              ),
            ]),
          ),
        )));
  }
}
