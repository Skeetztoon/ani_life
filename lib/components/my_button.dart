import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320,
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(203, 99, 99, 1),
          borderRadius: BorderRadius.circular(9)
        ),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )),
      );
  }
}
