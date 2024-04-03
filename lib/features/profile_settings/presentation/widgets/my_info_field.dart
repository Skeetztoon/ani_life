import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';

class MyInfoField extends StatelessWidget {
  final String title;
  final String fieldValue;
  final void Function()? onPressed;
  const MyInfoField(
      {super.key,
      required this.title,
      required this.fieldValue,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: fieldValue,
          ),
          onTap: onPressed,
        ),
      ],
    );
  }
}
