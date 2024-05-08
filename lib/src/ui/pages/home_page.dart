import 'package:flutter/material.dart';
import 'package:itca_construction/src/ui/pages/about_page.dart';
import 'package:itca_construction/src/ui/pages/groups/acabados_page.dart';
import 'package:itca_construction/src/ui/pages/groups/contreto_page.dart';
import 'package:itca_construction/src/ui/pages/groups/excavacion_page.dart';
import 'package:itca_construction/src/ui/pages/groups/mamposteria_page.dart';
import 'package:itca_construction/src/ui/pages/groups/pisos_page.dart';
import 'package:itca_construction/src/ui/pages/materiales_page.dart';
import 'package:itca_construction/src/ui/pages/tables_page.dart';

import 'groups/paredes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const titleSize = 30.0;
    return Scaffold(
      key: _scaffoldKey,
      drawer: _drawer(context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: kToolbarHeight,
            ),
            child: Image.asset(
              "assets/misc/icons/fn2.png",
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: kToolbarHeight + size.height * 0.09,
            ),
            child: SizedBox(
              height: size.height * 0.2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25,
                    left: 25,
                  ),
                  child: Row(
                    children: [
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "¿Qué estas\n",
                            style: TextStyle(
                                fontSize: titleSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        TextSpan(
                            text: " haciendo ",
                            style: TextStyle(
                                fontSize: titleSize + 3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        TextSpan(
                            text: "hoy?",
                            style: TextStyle(
                                fontSize: titleSize + 3,
                                fontWeight: FontWeight.w900,
                                color: Colors.white)),
                      ]))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight,
            child: IconButton(
                onPressed: () => _openDrawer(context),
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ),
          Positioned(
            top: kToolbarHeight + (size.height * 0.3),
            child: SizedBox(
              width: size.width,
              height: size.height * 0.7,
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "¡Bienvenido!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: 6,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ).copyWith(
                          bottom: 150,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return HomeButton(
                            onPressed: () => _openPage(context, index),
                            text: _getTitle(index),
                            imageSrc: _getImage(index),
                          );
                        }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return "Paredes";
      case 1:
        return "Mamposteria";
      case 2:
        return "Acabados";
      case 3:
        return "Concreto";
      case 4:
        return "Pisos";
      case 5:
        return "Excavación";
      default:
        return "";
    }
  }

  _getImage(int index) {
    switch (index) {
      case 0:
        return "assets/misc/Pared_Mesa de trabajo 1.png";
      case 1:
        return "assets/misc/Mamposteria_Mesa de trabajo 1.png";
      case 2:
        return "assets/misc/Acabados_Mesa de trabajo 1.png";
      case 3:
        return "assets/misc/Concreto_Mesa de trabajo 1.png";
      case 4:
        return "assets/misc/Pisos_Mesa de trabajo 1.png";

      case 5:
        return "assets/misc/excavacion.png";
      default:
        return "";
    }
  }

  _openPage(BuildContext context, int index) {
    Widget page;
    if (index == 0) {
      page = const ParedesPage();
    } else if (index == 1) {
      page = const MamposteriaPage();
    } else if (index == 2) {
      page = const AcabadosPage();
    } else if (index == 3) {
      page = const ConcretoPage();
    } else if (index == 4) {
      page = const PisosPage();
    } else {
      page = const ExcavacionPage();
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffafaeae),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/misc/logoicon.png"),
          ),
          DrawerItem(
            title: "Inicio",
            imageSrc: "assets/misc/inicio.png",
            onPressed: () => _openInicio(context),
          ),
          DrawerItem(
            title: "Tablas",
            imageSrc: "assets/misc/tablas.png",
            onPressed: () => _openTablas(context),
          ),
          DrawerItem(
            title: "Materiales",
            imageSrc: "assets/misc/materiales.png",
            onPressed: () => _openMateriales(context),
          ),
          DrawerItem(
            title: "Acerca de",
            imageSrc: "assets/misc/nosotros.png",
            onPressed: () => _openAboutPage(context),
          ),
        ],
      ),
    );
  }

  _openDrawer(BuildContext context) {
    _scaffoldKey.currentState?.openDrawer();
  }

  _openInicio(BuildContext context) {
    showAboutDialog(context: context);
  }

  _openMateriales(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MaterialesPage(),
      ),
    ).then((value) => Navigator.pop(context));
  }
  
  _openAboutPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AboutPage(),
      ),
    ).then((value) => Navigator.pop(context));
  }
  
  _openTablas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TablesPage(),
      ),
    ).then((value) => Navigator.pop(context));
  }
}

class HomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String imageSrc;
  const HomeButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 25,
            ),
            child: Center(
              child: Image.asset(
                imageSrc,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final String imageSrc;
  final VoidCallback onPressed;

  const DrawerItem({
    super.key,
    required this.title,
    required this.imageSrc,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed,
          leading: Image.asset(
            imageSrc,
            width: 35,
            height: 35,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const Divider(
          height: 0.5,
        ),
      ],
    );
  }
}
