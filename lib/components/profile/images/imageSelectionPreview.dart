import 'dart:typed_data';

import 'package:ani_life/components/profile/images/image_selection.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionPreview extends StatefulWidget {
  const ImageSelectionPreview({super.key});

  @override
  State<ImageSelectionPreview> createState() => _ImageSelectionPreviewState();
}

class _ImageSelectionPreviewState extends State<ImageSelectionPreview> {

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
                                                              // ТУТОР
                                                              // https://www.youtube.com/watch?v=5kjjkIdwwN8
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            _image != null ?
            CircleAvatar(
              radius: 64,
              backgroundImage: MemoryImage(_image!),
            ) :
            CircleAvatar(
              radius: 64,
            ),
            Positioned(
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white,),
                onPressed: () {},
              ),
              bottom: -10,
              left: 70,
            ),
            Positioned(
              child: IconButton(
                icon: Icon(Icons.add_circle_rounded, color: AniColorLight,),
                onPressed: () {selectImage();},
              ),
              bottom: -10,
              left: 70,
            ),
          ],
        ),
        SizedBox(height: 10,),

      ],
    );
  }
}

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData{

  Future<String> uploadImageToStorage(String fileName, Uint8List imageFile) async {
    Reference ref = _storage.ref().child(fileName);
    UploadTask uploadTask = ref.putData(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String imageUlr = await snapshot.ref.getDownloadURL();
    return imageUlr;
  }
  //
  // Future<String> saveImage({required Uint8List imageFile}) async {
  //   try {
  //     uploadImageToStorage(fileName, imageFile)
  //   }
  // }
}