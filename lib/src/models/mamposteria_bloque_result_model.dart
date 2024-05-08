import 'package:decimal/decimal.dart';

import 'result_model.dart';

class MamposteriaBloqueResultModel extends ResultItem {
  final Decimal desperdicioLadrillos;
  MamposteriaBloqueResultModel({
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

class SimpleValueResultModel extends ResultItem {
  SimpleValueResultModel({
    required super.descripcion,
    required super.unidad,
    required super.constante,
    required super.materialValor,
    required super.precioUnitario,
  });

  @override
  Decimal get valor {
    final result = materialValor;
    return result;
  }
}
