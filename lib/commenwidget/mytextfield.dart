import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const MyTextFieldWidget({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: text,
        labelText: text,
        border: const OutlineInputBorder(),
      ),
      controller: controller,
    );
  }
}
