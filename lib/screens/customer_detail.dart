import 'package:flutter/material.dart';

import '../bloc/costumer_detaill_bloc.dart';
import '../models/customer.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({
    super.key,
    required this.title,
    required this.customer,
  });

  final String title;
  final Customer customer;

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  late CustomerDetailBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CustomerDetailBloc(widget.customer);
  }

  Widget fieldText(String label, TextEditingController controller,
      bool isEditing, VoidCallback toggleEditing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: isEditing,
              decoration: InputDecoration(
                labelText: label,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.grey,
            ),
            onPressed: toggleEditing,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: "userImg ${widget.customer.id}",
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: 82,
                ),
              ),
              fieldText("Name", bloc.getNameController(), bloc.isEditingList[0],
                  () {
                setState(() {
                  bloc.toggleEditing(0);
                });
              }),
              const SizedBox(height: 32),
              ...List<Widget>.generate(
                widget.customer.addressList.length,
                (index) => fieldText(
                  "Address ${index + 1}",
                  bloc.addressListController()[index],
                  bloc.isEditingList[index + 1],
                  () {
                    setState(() {
                      bloc.toggleEditing(index + 1);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
