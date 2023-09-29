import 'package:flutter/material.dart';

import '../models/address.dart';
import '../models/customer.dart';

class CustomerDetailBloc {
  late final Customer customer;
  late List<bool> isEditingList;
  late List<String> addressStrList;
  late String customerName;
  late TextEditingController _nameController;
  late List<TextEditingController> _addressListController;

  CustomerDetailBloc(this.customer) {
    List<Address> addressList = customer.addressList;

    isEditingList = List<bool>.filled(
      addressList.length + 1,
      false,
    );

    addressStrList = List<String>.filled(
      addressList.length,
      "",
    );

    _addressListController = [];

    for (var i = 0; i < customer.addressList.length; i++) {
      addressStrList[i] = addressList[i].getFullAddress();
      _addressListController.add(
        TextEditingController(
          text: addressStrList[i],
        ),
      );
    }

    customerName = customer.name;
    _nameController = TextEditingController(
      text: customerName,
    );
  }

  void toggleEditing(int index) {
    isEditingList[index] = !isEditingList[index];
  }

  TextEditingController getNameController() {
    return _nameController;
  }

  List<TextEditingController> addressListController() {
    return _addressListController;
  }
}
