import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../screens/customer_detail.dart';

class CustomerListItem extends StatelessWidget {
  final Customer customer;
  final int index;
  final int length;

  const CustomerListItem({
    Key? key,
    required this.index,
    required this.customer,
    required this.length,
  }) : super(key: key);

  EdgeInsets getPadding(int index, int length) {
    final double topPadding = index == 0 ? 8 : 4;
    final double bottomPadding = index == length - 1 ? 8 : 4;

    return EdgeInsets.only(
      top: topPadding,
      left: 8,
      right: 8,
      bottom: bottomPadding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(index, length),
      child: Material(
        elevation: 1.0,
        child: ListTile(
          leading: Hero(
            tag: "userImg ${customer.id}",
            child: const Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: 42,
            ),
          ),
          title: Text(customer.name),
          subtitle: Text(
            customer.addressList[0].city,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerDetail(
                    title: "Detail",
                    customer: customer,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
