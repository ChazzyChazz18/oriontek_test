import 'dart:convert';

import 'address.dart';

class Customer {
  String id;
  String name;
  List<Address> addressList;

  Customer({
    required this.id,
    required this.name,
    required this.addressList,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    List<Address> addressList = [];
    var addressListFromJson = jsonDecode(json['addressList']);
    addressList = addressListFromJson
        .map((i) => Address.fromJson(i))
        .toList()
        .cast<Address>();
    return Customer(
      id: json['_id'],
      name: json['name'],
      addressList: addressList,
    );
  }
}
