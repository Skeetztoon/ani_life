import 'dart:async';
import 'dart:io';

import 'package:ani_life/features/posts/internal/new_post_provider.dart';
import 'package:ani_life/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:ani_life/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';

final imagePathProvider = StateProvider.autoDispose<String>((ref) => "");

class NewPostWidget extends ConsumerStatefulWidget {
  const NewPostWidget({super.key});

  @override
  NewPostWidgetState createState() => NewPostWidgetState();
}

class NewPostWidgetState extends ConsumerState<NewPostWidget> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  Future<String?> _selectImage(BuildContext context) async {
    final Completer<String?> completer = Completer<String?>();

    await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: const Column(
                        children: [
                          Icon(Icons.camera_alt_outlined),
                          Text("Сделать снимок"),
                        ],
                      ),
                      onTap: () async {
                        final imagePath = await _pickImage(ImageSource.camera);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                        completer.complete(imagePath);
                      },
                    ),
                    GestureDetector(
                      child: const Column(
                        children: [
                          Icon(Icons.filter),
                          Text("Выбрать в галерее"),
                        ],
                      ),
                      onTap: () async {
                        final imagePath = await _pickImage(ImageSource.gallery);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                        completer.complete(imagePath);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    return completer.future;
  }

  Future<String?> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return null;
    }

    final file = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (file == null) {
      return null;
    }
    logger.log(Level.FINE, "вот ваш путь к файлу: ${file.path}");
    return file.path;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = ref.watch(imagePathProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новая запись"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: textEditingController,
            builder: (context, value, child) {
              return IconButton(
                onPressed: value.text.isEmpty
                    ? null
                    : () async {
                        final String res =
                            await ref.watch(newPostProvider).createNewPost(
                                  textEditingController.text,
                                  imagePath,
                                );
                        ref.read(profileViewModelProvider.notifier).loadData();
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                res,
                                style: const TextStyle(color: Colors.black54),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          );
                        }
                      },
                icon: Icon(
                  Icons.check,
                  size: 30,
                  color: value.text.isEmpty ? Colors.black26 : Colors.black,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 20,
                    decoration: const InputDecoration(
                      hintText: "Что у вас нового?",
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                    controller: textEditingController,
                  ),
                ),
                (imagePath == "")
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  // minHeight: 256,
                                  // minWidth: 256,
                                  maxHeight:
                                      MediaQuery.of(context).size.width * 0.5,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: FileImage(
                                      File(
                                        imagePath,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  ref.read(imagePathProvider.notifier).state =
                                      "";
                                },
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: (imagePath == "")
            ? const Icon(Icons.add_a_photo_outlined)
            : const Icon(Icons.edit),
        onPressed: () async {
          final image = await _selectImage(context);
          if (image != null) {
            ref.read(imagePathProvider.notifier).state = image;
          }
        },
      ),
    );
  }
}
