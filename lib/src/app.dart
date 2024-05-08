import 'package:flutter/material.dart';

import 'ui/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Constru ITCA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange).copyWith(
          primary: const Color(0xffef7a05),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffe8e8e8),
        cardTheme: const CardTheme(
          elevation: 1,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
