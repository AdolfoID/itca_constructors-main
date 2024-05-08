import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../models/pdf_page.dart';

PdfPageFormat rotateToLeft(PdfPageFormat format) {
  return PdfPageFormat(
    format.height,
    format.width,
    marginTop: format.marginLeft,
    marginRight: format.marginRight,
    marginBottom: format.marginBottom,
    marginLeft: format.marginTop,
  );
}

class GenerePdfOutput {
  final List<PdfPageData> results;
  final String pdfTitle;
  final PdfPageFormat pageFormat;
  final int maxDecimals;
  GenerePdfOutput({
    required this.results,
    required this.pdfTitle,
    this.pageFormat = PdfPageFormat.a4,
    this.maxDecimals = 4,
  });

  Future<Uint8List> makePdf() async {
    final pdf = Document(
      author: "ITCA Construcciones",
      title: pdfTitle,
      subject: pdfTitle,
    );

    for (var page in results) {
      pdf.addPage(Page(
          pageFormat: rotateToLeft(pageFormat),
          orientation: PageOrientation.landscape,
          build: (context) {
            return DefaultTextStyle(
                style: const TextStyle(fontSize: 10),
                child: Column(children: [
                  ...page.results.map((element) {
                    final headerStyle =
                        Theme.of(context).header5.copyWith(fontSize: 11);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Table(
                            border: TableBorder.all(color: PdfColors.black),
                            columnWidths: {
                              0: const FixedColumnWidth(250),
                              1: const FixedColumnWidth(100),
                              2: const FixedColumnWidth(100),
                              3: const FixedColumnWidth(100),
                              4: const FixedColumnWidth(100),
                              5: const FixedColumnWidth(100),
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: PdfColors.red,
                                )),
                                children: [
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          element.title.toUpperCase(),
                                          style: Theme.of(context)
                                              .header5
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                          textAlign: TextAlign.left,
                                        )),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  // We can use an Expanded widget, and use the flex parameter to specify
                                  // how wide this particular widget should be. With a flex parameter of
                                  // 2, the description widget will be 66% of the available width.
                                  Expanded(
                                    child: paddedText(
                                      "DESCRIPCIÓN",
                                      style: headerStyle,
                                    ),
                                    flex: 2,
                                  ),
                                  // Again, with a flex parameter of 1, the cost widget will be 33% of the
                                  // available width.
                                  Expanded(
                                    child: paddedText(
                                      "UNIDAD",
                                      style: headerStyle,
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: paddedText(
                                      "C. POR M2",
                                      style: headerStyle,
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: paddedText(
                                      "CANTIDAD",
                                      style: headerStyle,
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: paddedText(
                                      "PU",
                                      style: headerStyle,
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: paddedText(
                                      "SUB TOTAL",
                                      style: headerStyle,
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                              ...element.items.map(
                                (e) => TableRow(
                                  children: [
                                    Expanded(
                                      child: paddedText(e.descripcion),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: paddedText(e.unidad),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: paddedText(
                                          e.constante.toStringAsFixed(maxDecimals)),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: paddedText(
                                          e.valor.toStringAsFixed(maxDecimals)),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: paddedText(
                                        e.precioUnitario.toStringAsFixed(maxDecimals),
                                        symbol: "\$",
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: paddedText(
                                        "\$${e.subTotal.toStringAsFixed(maxDecimals)}",
                                        symbol: "\$",
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                              TableRow(
                                children: [
                                  Expanded(
                                    child: paddedText(" "),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: paddedText(" "),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: paddedText(" "),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: paddedText(" "),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: paddedText("TOTAL"),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: paddedText(
                                      element.total.toStringAsFixed(2),
                                      symbol: "\$",
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ]),
                        SizedBox(height: 15),
                      ],
                    );
                  })
                ]));
          }));
    }

    return pdf.save();
  }
}

Widget paddedText(
  final String text, {
  String? symbol,
  final TextAlign align = TextAlign.right,
  TextStyle? style,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (symbol != null)
            Text(
              symbol,
              textAlign: align,
              style: style,
            ),
          Text(
            text,
            textAlign: align,
            style: style,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
