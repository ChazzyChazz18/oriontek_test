import '../models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class CustomerApi {
  String? host = dotenv.env['HOST'];
  String? customerApi = dotenv.env['CUSTOMER_API_URL'];

  Future<List<Customer>> getCustomers() async {
    final response = await http.get(Uri.parse('$host$customerApi'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<dynamic> customersJson = jsonResponse['customers'];
      return customersJson.map((item) => Customer.fromJson(item)).toList();
    } else {
      throw Exception(
        'Failed to load customers from API. Error: ${response.body}',
      );
    }
  }
}

abstract class ICustomerApi {
  Future<List<Customer>> getCustomers();
}

class StandartCustomerApi implements ICustomerApi {
  @override
  Future<List<Customer>> getCustomers() {
    return CustomerApi().getCustomers();
  }
}
