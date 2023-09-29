import 'package:flutter/material.dart';

import '../bloc/costumer_detaill_bloc.dart';
import '../models/customer.dart';
import '../widgets/custom_field_text.dart';

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
  late ICustomerDetailBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CustomerDetailBloc(widget.customer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: buildChildren(),
        ),
      ),
    );
  }

  List<Widget> buildChildren() {
    List<Widget> children = [
      Hero(
        tag: "userImg ${widget.customer.id}",
        child: const Icon(
          Icons.account_circle,
          color: Colors.grey,
          size: 82,
        ),
      ),
      CustomFieldText(
        label: "Name",
        controller: bloc.getNameController(),
        isEditing: bloc.isEditing(0),
        toggleEditing: () {
          setState(() {
            bloc.toggleEditing(0);
          });
        },
      ),
      const SizedBox(height: 32),
    ];

    for (int i = 0; i < widget.customer.addressList.length; i++) {
      children.add(CustomFieldText(
        label: "Address ${i + 1}",
        controller: bloc.addressListController()[i],
        isEditing: bloc.isEditing(i + 1),
        toggleEditing: () {
          setState(() {
            bloc.toggleEditing(i + 1);
          });
        },
      ));
    }

    return children;
  }
}
