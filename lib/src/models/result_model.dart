import 'package:decimal/decimal.dart';

class ResultItem {
  final String descripcion;
  final String unidad;
  final Decimal constante;
  final Decimal materialValor;
  final Decimal precioUnitario;

  ResultItem({
    required this.descripcion,
    required this.unidad,
    required this.constante,
    required this.materialValor,
    required this.precioUnitario,
  });

  Decimal get valor => constante * materialValor;
  Decimal get subTotal => valor * precioUnitario;

  @override
  String toString() {
    return '(material: $descripcion, unidad: $unidad, constante: $constante, materialValor: $materialValor, valor: $valor, precioUnitario: $precioUnitario, subTotal: $subTotal)\n';
  }
}
