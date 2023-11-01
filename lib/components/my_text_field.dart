import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.normal,),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: MyPrimaryColor, width: 2.0),
        ),
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
