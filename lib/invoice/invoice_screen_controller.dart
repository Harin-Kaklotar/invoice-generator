import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/model/seller.dart';

import '../model/product.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw; // pdfWidget

import '../preview/pdf_preview_screen.dart';


class InvoiceScreenController extends GetxController {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();

  List<Product> products = <Product>[].obs;

  void addProduct(
    String name,
    int quantity,
    double cost,
  ) {
    products.add(Product(name, quantity, cost));
  }

  void clearProducts() {
    products.clear();
  }

  void generateInvoice(){
    final companyName = companyNameController.text;
    final address = companyNameController.text;
    final phoneNumber = companyNameController.text;
    final email = companyNameController.text;
    final fax = companyNameController.text;
    final invoiceNumber = companyNameController.text;

    SellerBuilder builder = SellerBuilder(companyName);
    if(address.isNotEmpty) {
      builder.address = address;
    }
    if(phoneNumber.isNotEmpty) {
      builder.phoneNumber = phoneNumber;
    }
    if(email.isNotEmpty) {
      builder.email = email;
    }
    if(fax.isNotEmpty) {
      builder.fax = fax;
    }
    if(invoiceNumber.isNotEmpty) {
      builder.invoiceNumber = invoiceNumber;
    }


    Seller seller = builder.build();


  }

  // void generateInvoice() async {
  //   /// Create a PDF document
  //   final pdf = pw.Document();
  //
  //   final sellerName = sellerNameController.text;
  //   /// Get seller details from the controller
  //
  //   /// Define invoice data
  //   const invoiceNumber = 'INV001';
  //   final orderDate = DateTime.now();
  //   final dueDate = orderDate.add(const Duration(days: 30));
  //   const gstRegistrationNumber = 'GST1234567890';
  //   const bankDetails = 'Account Name: XYZ Bank, Account Number: 1234567890';
  //
  //   // Prompt user to select a logo file
  //   final logoFile = await FilePicker.platform.pickFiles(type: FileType.image);
  //
  //   // Check if a logo file was selected
  //   final hasLogo = logoFile != null && logoFile.files.isNotEmpty;
  //
  //   /// Define invoice table headers
  //   final headers = ['Product', 'Quantity', 'Cost'];
  //
  //   /// Define invoice table rows
  //   final rows = products
  //       .map((product) => [
  //             product.name,
  //             product.quantity.toString(),
  //             product.cost.toString()
  //           ])
  //       .toList();
  //
  //   /// Calculate the total cost of all products
  //   final totalCost = products
  //       .map((product) => product.quantity * product.cost)
  //       .reduce((value, element) => value + element);
  //
  //   /// Add content to the PDF document
  //   pdf.addPage(
  //     pw.Page(
  //         pageFormat: PdfPageFormat.a4,
  //         build: (pw.Context context){
  //           return pw.Center(
  //             child: pw.Column(
  //               children: [
  //                 pw.Text('Invoice', style: const pw.TextStyle(fontSize: 20)),
  //                 pw.SizedBox(height: 10),
  //
  //                 pw.Text(
  //                   'Seller Details:',
  //                   style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.Text('Company Name: $sellerName'),
  //                 /// Add other seller details
  //
  //                 pw.SizedBox(height: 10),
  //                 pw.Text(
  //                   'Invoice Details:',
  //                   style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.Text('Invoice Number: $invoiceNumber'),
  //                 pw.Text('Date of Order/Invoice: ${orderDate.toString()}'),
  //                 pw.Text('Due Date: ${dueDate.toString()}'),
  //                 pw.Text('GST Registration Number: $gstRegistrationNumber'),
  //                 pw.Text('Payment Details: $bankDetails'),
  //                 pw.SizedBox(height: 20),
  //
  //                 _buildLogo(pdf.document, hasLogo, logoFile!),
  //
  //                 pw.SizedBox(height: 20),
  //
  //                 pw.Text(
  //                   'Products:',
  //                   style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.Table.fromTextArray(
  //                   headers: headers,
  //                   data: rows,
  //                   border: pw.TableBorder.all(width: 1),
  //                   headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
  //                   cellStyle: const pw.TextStyle(),
  //                   cellAlignment: pw.Alignment.centerLeft,
  //                 ),
  //                 pw.SizedBox(height: 10),
  //                 pw.Row(
  //                   mainAxisAlignment: pw.MainAxisAlignment.end,
  //                   children: [
  //                     pw.Text(
  //                       'Total Cost: $totalCost',
  //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
  //                     ),
  //                   ],
  //                 ),
  //               ]
  //             )
  //           );
  //         }
  //     )
  //   );
  //
  //   // Generate the invoice file
  //   final Uint8List pdfBytes = await pdf.save();
  //
  //   // Display a preview of the invoice
  //   final pdfPreviewScreen = PdfPreviewScreen(pdfBytes: pdfBytes);
  //
  //   // Navigate to the preview screen
  //   Get.to(pdfPreviewScreen);
  //
  //
  //
  // }

  pw.Widget _buildLogo(PdfDocument pdf, bool hasLogo, FilePickerResult logoFile) {
    if (hasLogo) {
      final logoBytes = logoFile.files.first.bytes!;
      final logoImage = pw.MemoryImage(logoBytes);
      return pw.Image(logoImage, width: 100, height: 100);
    } else {
      return pw.SizedBox.shrink();
    }
  }
}
