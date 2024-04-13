import 'package:ani_life/features/posts/domain/entites/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard(this.postModel, {super.key});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        postHeader(
          context,
          postModel.authorNick,
          postModel.authorImage,
          postModel.createdAt,
        ), // автор и ава
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        postContent(
          context,
          postModel.postText,
          postModel.postImage,
        ), // текст и картинка
        postFooter(context), // кнопки
      ],
    );
  }

  Widget postHeader(
    BuildContext context,
    String authorName,
    String authorImage,
    String createdAt,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          (authorImage.isNotEmpty)
              ? CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(authorImage),
                )
              : const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.pets,
                    size: 25,
                  ),
                ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authorName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                createdAt, // TODO дата
                style: Theme.of(context).textTheme.titleSmall,
              ),
              // Divider(),
            ],
          ),
        ],
      ),
    );
  }

  Widget postContent(BuildContext context, String postText, String postImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            postText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        (postImage.isEmpty)
            ? Container()
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Image.network(
                  postImage,
                  fit: BoxFit.cover,
                ),
              ),
      ],
    );
  }

  Widget postFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Color(0xFFD5D5D5FF),
          //   ),
          //   padding: EdgeInsets.all(8),
          //   child: Icon(Icons.pets),
          // )
          Chip(
            avatar: const Icon(
              Icons.pets,
              size: 30,
            ),
            label: const Text(
              '88',
              style: TextStyle(fontSize: 20),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ],
      ),
    );
  }
}
