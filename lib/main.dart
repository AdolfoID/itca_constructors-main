import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itca_construction/src/app.dart';

import 'src/providers/price_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PriceProvider.instance.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}
