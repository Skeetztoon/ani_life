import 'dart:io';

import 'package:ani_life/features/user_images/presentation/round_image.dart';
import 'package:ani_life/main.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

class UserImage extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;

  const UserImage({super.key, required this.onFileChanged});

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;

  Future _selectImage() async {
    // bottomSheet для выбора источника фото
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
                          Text("Сделать снимок")
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    GestureDetector(
                      child: const Column(
                        children: [
                          Icon(Icons.filter),
                          Text("Выбрать в галерее")
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
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
  }

  Future _pickImage(ImageSource source) async {
    // пикаем имаге
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (file == null) {
      return;
    }

    await _uploadFile(file.path);
  }

  Future _uploadFile(String path) async {
    // аплоадим филе
    final fileName = DateTime.now().toIso8601String() + p.basename(path);
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child("usersImages")
        .child(fileName);

    try {
      final result = await ref.putFile(File(path));
      final fileUrl = await result.ref.getDownloadURL();
      usersCollection
          .doc(currentUser!.email)
          .update({"profileImage": fileName});

      setState(() {
        imageUrl = fileUrl;
      });

      widget.onFileChanged(fileUrl);
    } catch (e) {
      logger.log(Level.SEVERE, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Consumer(
              builder: (context, ref, child) {
                return CircleAvatar(
                  radius: 64,
                  child: (imageUrl == null)
                      ?
                  const Icon( // TODO add profileImageProvider to use as default image
                          Icons.person,
                          size: 65,
                        )
                      : RoundImage.url(
                          imageUrl!,
                          width: 135,
                          height: 135,
                        ),
                );
              },
            ),
            Positioned(
              bottom: -10,
              left: 70,
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Positioned(
              bottom: -10,
              left: 70,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: aniColorLight,
                ),
                onPressed: () async {
                  await _selectImage();
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
