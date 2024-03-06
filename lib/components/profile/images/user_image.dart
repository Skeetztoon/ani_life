import 'dart:io';

import 'package:ani_life/components/profile/images/round_image.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
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
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Сделать снимок"),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.filter),
              title: Text("Выбрать в галерее"),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(sourcePath: pickedFile.path, aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }

    await _uploadFile(file.path);
  }

  Future _uploadFile(String path) async {
    final fileName = "${DateTime.now().toIso8601String() + p.basename(path)}";
    final ref = storage.FirebaseStorage.instance.ref()
        .child("usersImages")
        .child(fileName);

    try {
      final result = await ref.putFile(File(path));
      final fileUrl = await result.ref.getDownloadURL();
      usersCollection.doc(currentUser!.email).update({"profileImage": fileName});

      setState(() {
        imageUrl = fileUrl;
      });

      widget.onFileChanged(fileUrl);
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 64,
              child: (imageUrl == null)
                  ? Icon(
                      Icons.person,
                      size: 65,
                    )
                  : RoundImage.url(
                      imageUrl!,
                      width: 135,
                      height: 135,
                    ),
            ),
            Positioned(
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              bottom: -10,
              left: 70,
            ),
            Positioned(
              child: IconButton(
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: AniColorLight,
                ),
                onPressed: () async {
                  await _selectImage();
                },
              ),
              bottom: -10,
              left: 70,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
