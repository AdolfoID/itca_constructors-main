import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

enum PriceItem {
  bloquesx15x20x40,
  dadosx15x20x40,
  bloquesx10x20x40,
  dadosx10x20x40,
  bloquesx20x20x40,
  dadosx20x20x40,
  cementoAlbanileriaTipoS,
  arena,
  aguaBarril,
  agua,
  dados,
  cementoTipo1,
  gravaChispa,
  grava,
  bloques,
  cementoTipoGU,
  piedra,
  ladrillo25x25,
  acero1_4,
  acero3_8,
  acero1_2,
  acero5_8,
  acero3_4,
  acero7_8,
  acero1,
  bloqueSolera10x20x40,
  bloqueSolera15x20x40,
  bloqueSolera20x20x40,
}
String toCamelCase(String str) {
  return str.toLowerCase().split(' ').map((word) {
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}

String getItemName(PriceItem item){
  var str = item.toString().replaceAll("PriceItem.", "");
 
  //search for each upercase and add a space before
  for (var i = 0; i < str.length; i++) {
    //AVOID NUMBERS
    if(int.tryParse(str[i]) != null) continue;
    if (str[i] == str[i].toUpperCase()) {
      str = "${str.substring(0, i)} ${str.substring(i)}";
      i++;
    }
  }
   str =  str.replaceAll("x", " x");
  return toCamelCase(str);
}

class PriceProvider extends ChangeNotifier {
  late final SharedPreferences _prefs;
  static final PriceProvider instance = PriceProvider._internal();

  PriceProvider._internal();
  static String get prex => 'settings_07';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _checkInitvalues();
  }

  void _checkInitvalues() {
    for (var element in PriceItem.values) {
      final key = prex + element.toString();
      switch (element) {
        case PriceItem.bloquesx15x20x40:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.69");
          }
          break;
        case PriceItem.dadosx15x20x40:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.44");
          }
        case PriceItem.bloquesx10x20x40:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.53");
          }
        case PriceItem.dadosx10x20x40:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.35");
          }
        case PriceItem.bloquesx20x20x40:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "1.00");
          }
        case PriceItem.dadosx20x20x40:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.65");
          }

        case PriceItem.cementoAlbanileriaTipoS:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "8.20");
          }
          break;
        case PriceItem.arena:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "33.50");
          }
          break;
        case PriceItem.agua:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.01");
          }
          break;
        case PriceItem.dados:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.44");
          }
          break;
        case PriceItem.cementoTipo1:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "9.50");
          }
          break;
        case PriceItem.gravaChispa:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "33.50");
          }
          break;
        case PriceItem.bloques:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.69");
          }
        case PriceItem.cementoTipoGU:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "8.50");
          }
        case PriceItem.piedra:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "21.66");
          }
        case PriceItem.grava:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "47.50");
          }
        case PriceItem.aguaBarril:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "1.58");
          }
        case PriceItem.acero1_4:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "46.20");
          }
        case PriceItem.acero3_8:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "57.80");
          }
        case PriceItem.acero1_2:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "64.09");
          }
        case PriceItem.acero5_8:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "57.61");
          }
        case PriceItem.acero3_4:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "57.80");
          }
        case PriceItem.acero7_8:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "58.13");
          }
        case PriceItem.acero1:
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "57.48");
          }
        case PriceItem.ladrillo25x25: // LADRILLO DE CEMENTO 25X25
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.63");
          }

          case PriceItem.bloqueSolera10x20x40: // SOLERA 10X20X40
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.63");
          }
           case PriceItem.bloqueSolera15x20x40: // SOLERA 15X20X40
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "0.82");
          }
          case PriceItem.bloqueSolera20x20x40: // SOLERA 20X20X40
          if (!_prefs.containsKey(key)) {
            _prefs.setString(key, "1.15");
          }
          break;
      }
    }
  }

  List<Tuple2<Decimal, PriceItem>> getPrices() {
    return PriceItem.values.map((e) => Tuple2(getPrice(e), e)).toList();
  }

  Decimal getPrice(PriceItem item) {
    final key = prex + item.toString();
    final strValue = _prefs.getString(key);
    if (strValue == null) {
      return Decimal.zero;
    }
    return Decimal.parse(strValue);
  }

  Map<PriceItem, TextEditingController> _controllers = {};
  TextEditingController getController(Tuple2<Decimal, PriceItem> price) {
    final item = price.item2;
    if (!_controllers.containsKey(item)) {
      _controllers[item] = TextEditingController(text: price.item1.toString());
    }
    return _controllers[item]!;
  }

  void savePrices() {
    for (var element in _controllers.entries) {
      final key = prex + element.key.toString();
      final value = element.value.text;
      _prefs.setString(key, value);
    }
  }
}
