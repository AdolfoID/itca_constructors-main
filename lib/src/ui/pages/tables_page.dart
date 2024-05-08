import 'package:flutter/material.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

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
                "assets/tables/Tablas1.jpg",
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/tables/Tablas2.jpg",
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/tables/Tablas3.jpg",
                width: double.infinity,
              ),
            ]),
          ),
        )));
  }
}
