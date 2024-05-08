import 'package:decimal/decimal.dart';

import 'result_model.dart';

class ConcretoCeldaResultModel extends ResultItem {
  final Decimal desperdicioMortero;
  ConcretoCeldaResultModel({
    required super.descripcion,
    required super.unidad,
    required super.constante,
    required super.materialValor,
    required super.precioUnitario,
    required this.desperdicioMortero,
  });

  @override
  Decimal get valor => ((materialValor * Decimal.parse("0.0252")) *
          constante *
          (desperdicioMortero + Decimal.one))
      .round();
}
