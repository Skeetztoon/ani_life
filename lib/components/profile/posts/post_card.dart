import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostHeader(), // автор и ава
        Divider(indent: 20,
        endIndent: 20,),
        PostContent(), // текст и картинка
        PostFooter(), // кнопки
      ],
    );
  }
}

class PostHeader extends StatelessWidget { // Автор и ава
  const PostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: Icon(Icons.pets, size: 25,),
          ),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Иван Иванов",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),
              Text(
                "Вчера 17:01",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              // Divider(),
            ],
          )
        ],
      ),
    );
  }
}

class PostContent extends StatelessWidget { // текст и картинка
  const PostContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            "Маруся устала",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width, color: Colors.red,)
      ],
    );
  }
}

class PostFooter extends StatelessWidget { // кнопки
  const PostFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
            avatar: Icon(Icons.pets, size: 30,),
            label: Text('88', style: TextStyle(fontSize: 20),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ],
      ),
    );
  }
}
