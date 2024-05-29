import 'package:decimal/decimal.dart';

extension StringToDecimal on String {
  Decimal toDecimal() {
    return Decimal.parse(this);
  }
}

extension DoubleToDecimal on double {
  Decimal toDecimal() {
    return Decimal.parse(toString());
  }

  Decimal get d {
    return Decimal.parse(toString());
  }
}
