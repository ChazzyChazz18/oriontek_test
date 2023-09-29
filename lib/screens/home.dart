import 'package:flutter/material.dart';

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
  late ICustomerApi customerApi;

  @override
  void initState() {
    super.initState();
    customerApi = StandartCustomerApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      future: customerApi.getCustomers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildListView(snapshot.data!);
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
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        return CustomerListItem(
          customer: customers[index],
          index: index,
          length: customers.length,
        );
      },
    );
  }
}
