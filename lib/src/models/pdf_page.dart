import 'package:itca_construction/src/models/result_data_for_pdf_model.dart';

class PdfPageData {
  final List<ResultDataForPdfModel> results;

  PdfPageData({required this.results});

  @override
  String toString() => 'PdfPageData(results: $results)';
}
