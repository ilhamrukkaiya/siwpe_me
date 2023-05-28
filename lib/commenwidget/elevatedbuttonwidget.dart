// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onpress;
  const MyElevatedButton({
    Key? key,
    required this.text,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      child: Text(text),
    );
  }
}
