import 'dart:io';

import 'package:ani_life/features/posts/domain/repositories/new_post_repository.dart';
import 'package:ani_life/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:path/path.dart' as p;

class NewPostRepositoryImpl extends NewPostRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection("users");


  @override
  Future<String> createNewPost(String postText, String imageUrl) async {
    late final String fileName;
    if (imageUrl.isEmpty) {
      fileName = "";
    } else {
      final fileName = DateTime.now().toIso8601String() + p.basename(imageUrl);
      try {
        storage.FirebaseStorage.instance
            .ref()
            .child("postsImages")
            .child(fileName)
            .putFile(File(imageUrl));
      } catch (e) {
        logger.log(Level.SEVERE, e);
        return "Произолша ошибка, попробуйте снова";
      }
    }
    var userDoc =
    await _firestore.collection("users").doc(currentUser!.email).get();
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    Map<String, dynamic> postData = {
      "authorEmail": currentUser!.email,
      "authorNick": userData["username"],
      "authorImage": userData["profileImage"],
      "createDate": DateFormat.yMd().add_Hm().format(DateTime.now()),
      "text": postText,
      "postImage": fileName,
    };
    try {
      await _firestore.collection("posts").add(postData);
      return "Запись создана";
    } catch (e) {
      logger.log(Level.SEVERE, e);
      return "Произолша ошибка, попробуйте снова";
    }
  }
}