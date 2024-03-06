import 'package:ani_life/components/my_button.dart';
import 'package:ani_life/components/profile/posts/post_card.dart';
import 'package:ani_life/components/profile_button.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';

class PostsSection extends StatefulWidget {
  const PostsSection({super.key});

  @override
  State<PostsSection> createState() => _PostsSectionState();
}

class _PostsSectionState extends State<PostsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ProfileButton(text: "Создать новую запись"),
          PostCard(),
        ],
      ),
    );
  }
}
