import 'package:invoice_generator/model/buyer.dart';
import 'package:invoice_generator/model/product.dart';
import 'package:invoice_generator/model/seller.dart';

class Invoice {
  Seller seller;
  Buyer buyer;
  List<Product> products;
  Invoice(this.seller, this.buyer, this.products);
}
