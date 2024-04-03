import 'package:ani_life/features/posts/presentation/new_post_screen.dart';
import 'package:ani_life/features/posts/presentation/widgets/post_card.dart';
import 'package:ani_life/features/posts/presentation/widgets/profile_button.dart';
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
          ProfileButton(
            text: "Создать новую запись",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewPostWidget(),
                ),
              );
            },
          ),
          const PostCard(),
        ],
      ),
    );
  }
}
