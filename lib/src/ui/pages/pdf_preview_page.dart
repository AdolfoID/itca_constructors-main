import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../models/pdf_page.dart';
import '../../utils/genere_pdf_output.dart';

class PdfPreviewPage extends StatefulWidget {
  final List<PdfPageData> results;
  final String pdfTitle;
  const PdfPreviewPage({
    Key? key,
    required this.results,
    required this.pdfTitle,
  }) : super(key: key);

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  PdfPageFormat pageFormat = PdfPageFormat.a4;

  bool showPrinter = kDebugMode ? false : true;
  Completer<Uint8List> pdfData = Completer<Uint8List>();

  final controller = Completer<PDFViewController>();

  @override
  void initState() {
    super.initState();

    GenerePdfOutput(
      pdfTitle: widget.pdfTitle,
      results: widget.results,
    ).makePdf().then(
          (value) => pdfData.complete(value),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfTitle),
        actions: [
          if (showPrinter)
            IconButton(
              icon: const Icon(Icons.picture_as_pdf_outlined),
              onPressed: () {
                setState(() {
                  showPrinter = false;
                });
              },
            ),
          if (!showPrinter)
            IconButton(
              icon: const Icon(Icons.print_outlined),
              onPressed: () async {
                setState(() {
                  showPrinter = true;
                });
              },
            ),
        ],
      ),
      body: showPrinter
          ? PdfPreview(
              initialPageFormat: pageFormat,
              canChangeOrientation: false,
              onPageFormatChanged: (format) {
                setState(() {
                  pageFormat = format;
                });
              },
              loadingWidget: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(height: 10),
                    Text('Generando PDF...'),
                  ],
                ),
              ),
              build: (context) => pdfData.future,
            )
          : Builder(
              builder: (context) {
                return FutureBuilder(
                  future: pdfData.future,
                  builder: (context, snap) {
                    if (snap.data == null) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator.adaptive(),
                            SizedBox(height: 10),
                            Text('Generando PDF...'),
                          ],
                        ),
                      );
                    }
                    return PDFView(
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: true,
                      pageFling: false,
                      fitPolicy: FitPolicy.WIDTH,
                      pdfData: snap.data!,
                      fitEachPage: true,
                    );
                  },
                );
              },
            ),
    );
  }
}
