import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';

class FriendsButton extends StatefulWidget {
  const FriendsButton({super.key});

  @override
  State<FriendsButton> createState() => _FriendsButtonState();
}

class _FriendsButtonState extends State<FriendsButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        width: MediaQuery.of(context).size.width,
        child: Text(
          "10 друзей",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Color(0xFF424530)),
        ),
      ),
    );
  }
}
