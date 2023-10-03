import 'package:oriontek_test/models/address_service.dart';

import '../models/address.dart';
import '../models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class CustomerApi {
  String? host = dotenv.env['HOSTCRUD'];
  String? customerApiGet = dotenv.env['CRUD_GET_URL'];
  String? customerApiPost = dotenv.env['CRUD_POST_URL'];
  String? customerApiDelete = dotenv.env['CRUD_DEL_URL'];

  Future<List<Customer>> getCustomers() async {
    final getResponse = await http.get(
      Uri.parse('$host$customerApiGet'),
    );

    if (getResponse.statusCode == 200) {
      var jsonResponse = json.decode(getResponse.body);
      List<dynamic> customersJson = jsonResponse;
      return customersJson.map((item) => Customer.fromJson(item)).toList();
    } else {
      throw Exception(
        'Failed to load customers from API. Error: ${getResponse.body}',
      );
    }
  }

  Future<String> addCustomer({
    required String name,
    required List<Address> addressList,
  }) async {
    final postResponse = await http.post(
      Uri.parse('$host$customerApiPost'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "addressList": AddressService(addressList).getAddressesAsJson(),
      }),
    );

    if (postResponse.statusCode == 200) {
      return "Customer Added!";
    } else {
      return 'Failed to load customers from API';
    }
  }

  Future<String> deleteCustomer({
    required String id,
  }) async {
    final deleteResponse = await http.delete(
      Uri.parse('$host$customerApiPost/$id'),
    );

    if (deleteResponse.statusCode == 200) {
      return "Customer Deleted!";
    } else {
      return 'Failed to delete customer from API';
    }
  }
}

// Get all customers
abstract class IGetCustomerApi {
  Future<List<Customer>> getCustomers();
}

class StandartCustomerGetApi implements IGetCustomerApi {
  @override
  Future<List<Customer>> getCustomers() {
    return CustomerApi().getCustomers();
  }
}

// Add a customer
abstract class IAddCustomerApi {
  Future<String> addCustomer({
    required name,
    required List<Address> addressList,
  });
}

class StandartCustomerAddApi implements IAddCustomerApi {
  @override
  Future<String> addCustomer({
    required name,
    required List<Address> addressList,
  }) {
    return CustomerApi().addCustomer(
      name: name,
      addressList: addressList,
    );
  }
}

// Delete a customer
abstract class IDeleteCustomerApi {
  Future<String> deleteCustomer({
    required String id,
  });
}

class StandartCustomerDeleteApi implements IDeleteCustomerApi {
  @override
  Future<String> deleteCustomer({
    required String id,
  }) {
    return CustomerApi().deleteCustomer(
      id: id,
    );
  }
}
