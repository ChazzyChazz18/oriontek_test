import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oriontek_test/models/address.dart';

import '../apis/customer_api.dart';
import '../models/customer.dart';
import '../widgets/customer_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Customer> customerList = [];
  late IGetCustomerApi customerGetApi;
  late IAddCustomerApi customerAddApi;
  late IDeleteCustomerApi customerDeleteApi;
  late TextEditingController customerNameController;

  @override
  void initState() {
    super.initState();

    customerNameController = TextEditingController();

    // Getting all customers
    customerGetApi = StandartCustomerGetApi();

    // Add a new customer
    customerAddApi = StandartCustomerAddApi();

    // Deleting an existing customer
    customerDeleteApi = StandartCustomerDeleteApi();
  }

  void showAddCustomerModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new Customer!'),
          content: TextField(
            controller: customerNameController,
            decoration: const InputDecoration(
              labelText: "Customer Name",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () => saveCustomer(),
            ),
          ],
        );
      },
    );
  }

  void saveCustomer() {
    // We get the string from the textfield
    String customerName = customerNameController.text;

    // This whole process is to add a random number of address
    List<Address> addressToAddList = [];

    String customerAddressID =
        DateTime.now().millisecondsSinceEpoch.toString().substring(10, 13);

    final random = Random();
    int numberOfAddress = random.nextInt(5) + 1;

    for (int i = 0; i < numberOfAddress; i++) {
      addressToAddList.add(Address(
        country: "country $customerAddressID",
        city: "city $customerAddressID",
        street: "street $customerAddressID",
        houseNumber: "houseNumber $customerAddressID",
      ));
    }

    // Here we send our add request to the endpoint
    customerAddApi
        .addCustomer(
          name: customerName,
          addressList: addressToAddList,
        )
        .then(
          (value) => onAddCustomerSuccessfull(customerName),
        );
  }

  void onAddCustomerSuccessfull(String customerName) {
    // Here we show we just added a new customer
    final snackBar = SnackBar(
      content: Text('Customer: $customerName added!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // Here we refresh the screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          title: widget.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showAddCustomerModal();
            },
          ),
        ],
      ),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return Container(
      color: const Color.fromARGB(255, 229, 229, 229),
      child: buildFutureBuilder(),
    );
  }

  Widget buildFutureBuilder() {
    return FutureBuilder<List<Customer>>(
      future: customerGetApi.getCustomers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return buildListView(snapshot.data!);
          } else {
            return const Center(
              child: Text(
                "There are no users registered... \nBut you can add one on the plus button on the top right corner!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildListView(List<Customer> customers) {
    var customerListReversed = customers.reversed.toList();
    return ListView.builder(
      itemCount: customerListReversed.length,
      itemBuilder: (context, index) {
        return CustomerListItem(
          screenTitle: widget.title,
          customer: customerListReversed[index],
          index: index,
          length: customerListReversed.length,
          customerDeleteApi: customerDeleteApi,
        );
      },
    );
  }
}
