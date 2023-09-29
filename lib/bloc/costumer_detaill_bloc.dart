import 'package:flutter/material.dart';

import '../models/customer.dart';

abstract class ICustomerDetailBloc {
  TextEditingController getNameController();
  List<TextEditingController> addressListController();
  bool isEditing(int index);
  void toggleEditing(int index);
}

class CustomerDetailBloc implements ICustomerDetailBloc {
  final Customer customer;
  late List<TextEditingController> _controllers;
  late List<bool> _isEditingList;

  CustomerDetailBloc(this.customer) {
    _controllers = [
      TextEditingController(text: customer.name),
      ...customer.addressList
          .map((address) => TextEditingController(text: address.city)),
    ];
    _isEditingList = List.filled(_controllers.length, false);
  }

  @override
  TextEditingController getNameController() {
    return _controllers[0];
  }

  @override
  List<TextEditingController> addressListController() {
    return _controllers.sublist(1);
  }

  @override
  bool isEditing(int index) {
    return _isEditingList[index];
  }

  @override
  void toggleEditing(int index) {
    _isEditingList[index] = !_isEditingList[index];
  }
}
