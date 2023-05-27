import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw; // pdfWidget

import '../preview/pdf_preview_screen.dart';

class InvoiceUtil{

  static   void generateInvoice() async {
    /// Create a PDF document
    final pdf = pw.Document();

    final sellerName = sellerNameController.text;
    /// Get seller details from the controller

    /// Define invoice data
    const invoiceNumber = 'INV001';
    final orderDate = DateTime.now();
    final dueDate = orderDate.add(const Duration(days: 30));
    const gstRegistrationNumber = 'GST1234567890';
    const bankDetails = 'Account Name: XYZ Bank, Account Number: 1234567890';

    // Prompt user to select a logo file
    final logoFile = await FilePicker.platform.pickFiles(type: FileType.image);

    // Check if a logo file was selected
    final hasLogo = logoFile != null && logoFile.files.isNotEmpty;

    /// Define invoice table headers
    final headers = ['Product', 'Quantity', 'Cost'];

    /// Define invoice table rows
    final rows = products
        .map((product) => [
      product.name,
      product.quantity.toString(),
      product.cost.toString()
    ])
        .toList();

    /// Calculate the total cost of all products
    final totalCost = products
        .map((product) => product.quantity * product.cost)
        .reduce((value, element) => value + element);

    /// Add content to the PDF document
    pdf.addPage(
        pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context){
              return pw.Center(
                  child: pw.Column(
                      children: [
                        pw.Text('Invoice', style: const pw.TextStyle(fontSize: 20)),
                        pw.SizedBox(height: 10),

                        pw.Text(
                          'Seller Details:',
                          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text('Company Name: $sellerName'),
                        /// Add other seller details

                        pw.SizedBox(height: 10),
                        pw.Text(
                          'Invoice Details:',
                          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text('Invoice Number: $invoiceNumber'),
                        pw.Text('Date of Order/Invoice: ${orderDate.toString()}'),
                        pw.Text('Due Date: ${dueDate.toString()}'),
                        pw.Text('GST Registration Number: $gstRegistrationNumber'),
                        pw.Text('Payment Details: $bankDetails'),
                        pw.SizedBox(height: 20),

                        _buildLogo(pdf.document, hasLogo, logoFile!),

                        pw.SizedBox(height: 20),

                        pw.Text(
                          'Products:',
                          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Table.fromTextArray(
                          headers: headers,
                          data: rows,
                          border: pw.TableBorder.all(width: 1),
                          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          cellStyle: const pw.TextStyle(),
                          cellAlignment: pw.Alignment.centerLeft,
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Total Cost: $totalCost',
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ]
                  )
              );
            }
        )
    );

    // Generate the invoice file
    final Uint8List pdfBytes = await pdf.save();

    // Display a preview of the invoice
    final pdfPreviewScreen = PdfPreviewScreen(pdfBytes: pdfBytes);

    // Navigate to the preview screen
    Get.to(pdfPreviewScreen);



  }


}