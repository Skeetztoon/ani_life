import 'package:ani_life/components/profile/posts/profile_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/widgets.dart';

class NewPostWidget extends StatefulWidget {
  const NewPostWidget({super.key});

  @override
  State<NewPostWidget> createState() => _NewPostWidgetState();
}

class _NewPostWidgetState extends State<NewPostWidget> {
  TextEditingController _textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Новая запись"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                size: 30,
                color: (_textEditingController.text.isEmpty) ? Colors.black26 : Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Что у вас нового?",
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            controller: _textEditingController,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo_outlined),
        onPressed: () {},
      ),
    );
  }
}
