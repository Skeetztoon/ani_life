import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart%20';
import 'package:intl/intl.dart';

class Post {
  final String authorEmail; // через currenUser!.email
  final String authorNick; // через ???
  final String authorImage; // через ???
  final String createDate; // через ???
  final String postText; //  из textEdit
  final String postImage; // как аву

  Post(this.postImage,
      {required this.authorEmail,
      required this.authorNick,
      required this.authorImage,
      required this.createDate,
      required this.postText});
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final currentUser = FirebaseAuth.instance.currentUser;

Future<bool> createPost(String postText) async {
  var userDoc = await _firestore.collection("users").doc(currentUser!.email).get();
  Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
  print("получены данные пользователя");
  Map<String, dynamic> postData = {
    "authorEmail": currentUser!.email,
    "authorNick": userData["username"],
    "text": postText,
    "authorImage": userData["profileImage"],
    "createDate": DateFormat.yMd().add_Hm().format(DateTime.now()),
  };
  try {
    print("Попытка отправить данные");
    await _firestore.collection("posts").add(postData);
    print("Данные отправлены");
    return true;
  } catch (e) {
    print("Что-то пошло не так");
    print(e);
  }
  return false;
}
