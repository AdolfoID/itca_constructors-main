import 'package:decimal/decimal.dart';

import 'result_model.dart';

class ExcavacionResultModel extends ResultItem {
  final Decimal desperdicioLadrillos;
  ExcavacionResultModel({
    required super.descripcion,
    required super.unidad,
    required super.constante,
    required super.materialValor,
    required super.precioUnitario,
    required this.desperdicioLadrillos,
  });

  @override
  Decimal get valor {
    final result =
        materialValor * constante * (desperdicioLadrillos + Decimal.one);
    return result;
  }
}