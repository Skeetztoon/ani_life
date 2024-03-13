import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const ProfileButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
                color: AniColorPrimary,
                borderRadius: BorderRadius.circular(9)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            )),
      ),
    );
  }
}