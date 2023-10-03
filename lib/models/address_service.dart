import 'dart:convert';
import 'address.dart';

class AddressService {
  List<Address> addresses = [];

  AddressService.empty();
  AddressService(this.addresses);

  String getAddressesAsJson() {
    List<Map<String, dynamic>> addressList = addresses
        .map(
          (address) => {
            'country': address.country,
            'city': address.city,
            'street': address.street,
            'houseNumber': address.houseNumber,
          },
        )
        .toList();

    return jsonEncode(addressList);
  }

  List<Address> getAddressesFromJson(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Address> addressList = jsonList
        .map(
          (item) => Address(
            country: item['country'],
            city: item['city'],
            street: item['street'],
            houseNumber: item['houseNumber'],
          ),
        )
        .toList();

    return addressList;
  }
}
