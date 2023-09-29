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
    var addressListFromJson = json['addressList'] as List;
    List<Address> addressList =
        addressListFromJson.map((i) => Address.fromJson(i)).toList();
    return Customer(
      id: json['id'],
      name: json['name'],
      addressList: addressList,
    );
  }
}
