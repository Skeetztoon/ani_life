import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  // Виджет для отображения аватарки
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> _fetchProfilePictureUrl() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    // Fetch the user document to get the list of owned pet IDs
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(currentUser!.email).get();
    String fileName = userDoc['profileImage'];

    try {
      final ref = FirebaseStorage.instance.ref().child('usersImages/$fileName');
      final url = await ref.getDownloadURL();
      print("URL IS $url");
      return url;
    } catch (e) {
      print(e);
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchProfilePictureUrl(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if ((snapshot.hasError) || (snapshot.data == "")) {
            return Image.asset("assets/images/no-image-image.png");
          } else {
            return Image.network(snapshot.data!);
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
