import 'package:flutter/material.dart';

class NewPostWidget extends StatefulWidget {
  const NewPostWidget({super.key});

  @override
  State<NewPostWidget> createState() => _NewPostWidgetState();
}

class _NewPostWidgetState extends State<NewPostWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новая запись"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {}, //TODO добавление записи
            icon: Icon(
              Icons.check,
              size: 30,
              color: (_textEditingController.text.isEmpty)
                  ? Colors.black26
                  : Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: TextField(
            decoration: const InputDecoration(
              hintText: "Что у вас нового?",
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            controller: _textEditingController,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_a_photo_outlined),
        onPressed: () {}, //TODO прикрепление фото
      ),
    );
  }
}
