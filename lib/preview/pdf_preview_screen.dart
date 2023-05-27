import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  final Uint8List pdfBytes;

  const PdfPreviewScreen({required this.pdfBytes, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Preview'),
      ),
      body: PdfPreview(
        build: (format) => pdfBytes,
        allowPrinting: false,
        allowSharing: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        useActions: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Printing.sharePdf(bytes: pdfBytes, filename: 'invoice.pdf');
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
