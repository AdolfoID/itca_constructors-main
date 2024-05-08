
import 'package:decimal/decimal.dart';
import 'package:itca_construction/src/models/result_model.dart';
import 'package:itca_construction/src/utils/string_to_decimal.dart';

class VarillasResultModel extends ResultItem {
  VarillasResultModel({
    required super.descripcion,
    required super.unidad,
    required super.constante,
    required super.materialValor,
    required super.precioUnitario,
  });

  @override
  Decimal get valor {
    final result = (materialValor / constante).toDouble().d;
    return result ;
  }
}
