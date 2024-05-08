import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import 'result_model.dart';

class ResultDataForPdfModel {
  final String title;
  final Color titleBackColor;
  final List<ResultItem> items;

  ResultDataForPdfModel({
    required this.items,
    required this.title,
    required this.titleBackColor,
  });

  Decimal get total => items.fold(
        Decimal.zero,
        (previousValue, element) => previousValue + element.subTotal,
      );

  @override
  String toString() =>
      'ResultDataForPdfModel(title: $title, titleBackColor: $titleBackColor, items: $items)';
}
