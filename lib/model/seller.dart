import 'package:flutter/foundation.dart';

class Seller{
 late String _companyName;
  String? _address;
  String? _phoneNumber;
  String? _otherPhoneNumber;
  String? _email;
  String? _fax;
  String? _logo;
  String? _invoiceNumber;

  Seller(SellerBuilder builder){
   _companyName = builder.companyName!;
    _address = builder.address;
    _phoneNumber = builder.phoneNumber;
    _otherPhoneNumber = builder.otherPhoneNumber;
    _email = builder.email;
    _fax = builder.fax;
    _logo = builder.logo;
    _invoiceNumber = builder.invoiceNumber;
  }

  String get companyName => _companyName;
  String? get address => _address;
  String? get phoneNumber => _phoneNumber;
  String? get otherPhoneNumber => _otherPhoneNumber;
  String? get email => _email;
  String? get fax => _fax;
  String? get logo => _logo;
  String? get invoiceNumber => _invoiceNumber;
}

class SellerBuilder {
  String _companyName;
  String? _address;
  String? _phoneNumber;
  String? _otherPhoneNumber;
  String? _email;
  String? _fax;
  String? _logo;
  String? _invoiceNumber;

  SellerBuilder(this._companyName);

  String get companyName => _companyName;
  set companyName(String name) {
    _companyName = name;
  }

  String? get address => _address;
  set address(String? address) {
    _address = address;
  }

  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  String? get otherPhoneNumber => _otherPhoneNumber;
  set otherPhoneNumber(String? otherPhoneNumber) {
    _otherPhoneNumber = otherPhoneNumber;
  }

  String? get email => _email;
  set email(String? email) {
    _email = email;
  }

  String? get fax => _fax;
  set fax(String? fax) {
    _fax = fax;
  }

  String? get logo => _logo;
  set logo(String? logo) {
    _logo = logo;
  }

  String? get invoiceNumber => _invoiceNumber;
  set invoiceNumber(String? invoiceNumber) {
    _invoiceNumber = invoiceNumber;
  }

  Seller build() {
    return Seller(this);
  }
}