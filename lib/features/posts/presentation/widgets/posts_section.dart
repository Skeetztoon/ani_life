import 'package:ani_life/features/posts/domain/entites/post_model.dart';
import 'package:ani_life/features/posts/presentation/new_post_screen.dart';
import 'package:ani_life/features/posts/presentation/widgets/post_card.dart';
import 'package:ani_life/features/posts/presentation/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsSection extends ConsumerWidget {
  const PostsSection(
    this.posts, {
    super.key,
  });

  final List<PostModel> posts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          (posts.isEmpty)
              ? const Text("У вас пока нет постов")
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: posts.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (context, index) {
                    return PostCard(posts[index]);
                  },
                ),
        ],
      ),
    );
  }
}
