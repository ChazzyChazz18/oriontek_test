import 'package:flutter/material.dart';

class CustomFieldText extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEditing;
  final VoidCallback toggleEditing;

  const CustomFieldText({
    Key? key,
    required this.label,
    required this.controller,
    required this.isEditing,
    required this.toggleEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
