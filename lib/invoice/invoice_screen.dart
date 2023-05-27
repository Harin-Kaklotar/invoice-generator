import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/invoice/invoice_screen_controller.dart';


class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({Key? key}) : super(key: key);

  final InvoiceScreenController _controller =
      Get.put(InvoiceScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seller Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller.companyNameController,
                decoration: const InputDecoration(labelText: 'Company Name'),
              ),
              // Add other input fields for seller details here
              const SizedBox(height: 16),
              const Text(
                'Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Obx(
                () => DataTable(
                  columns: const [
                    DataColumn(label: Text('Product')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Cost')),
                  ],
                  rows: _controller.products
                      .map(
                        (product) => DataRow(
                          cells: [
                            DataCell(Text(product.name)),
                            DataCell(Text(product.quantity.toString())),
                            DataCell(Text(product.cost.toString())),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      _addProduct(context);
                    },
                    //onPressed: _addProduct(context),
                    child: const Text('Add Product'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _controller.generateInvoice,
                child: const Text('Generate Invoice'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addProduct(BuildContext context) {
    if(context.mounted){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String productName = 'Dummy Item';
          int productQuantity = 1;
          double productCost = 0.0;

          return AlertDialog(
            title: const Text('Add Product'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Product Name'),
                    onChanged: (value) => productName = value,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Product quantity'),
                    onChanged: (value) =>
                    productQuantity = int.tryParse(value) ?? 1,
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Product Cost'),
                    onChanged: (value) =>
                    productCost = double.tryParse(value) ?? 0.0,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _controller.addProduct(productName,productQuantity, productCost);
                  Get.back();
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    }
  }

}
