import 'package:flutter/material.dart';

class CustomTextAlignment extends StatelessWidget {
  final String text;
  const CustomTextAlignment({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
