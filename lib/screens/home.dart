import 'package:flutter/material.dart';

import '../apis/customer_api.dart';
import '../models/customer.dart';
import 'customer_detail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Customer> customerList = [];
  late CustomerApi customerApi;

  @override
  void initState() {
    super.initState();
    customerApi = CustomerApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: const Color.fromARGB(255, 229, 229, 229),
        child: FutureBuilder<List<Customer>>(
          future: customerApi.getCustomers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? 8 : 4,
                      left: 8,
                      right: 8,
                      bottom: index == snapshot.data!.length - 1 ? 8 : 4,
                    ),
                    child: Material(
                      elevation: 1.0,
                      child: ListTile(
                        leading: Hero(
                          tag: "userImg ${snapshot.data![index].id}",
                          child: const Icon(
                            Icons.account_circle,
                            color: Colors.grey,
                            size: 42,
                          ),
                        ),
                        title: Text(snapshot.data![index].name),
                        subtitle: Text(
                          snapshot.data![index].addressList[0].city,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Handle your edit functionality here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerDetail(
                                  title: "Detail",
                                  customer: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
