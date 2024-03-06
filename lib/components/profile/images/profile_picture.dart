import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String imageUrl = "";


  @override
  void initState() {
    super.initState();
    _fetchProfilePicture();
  }

  Future<void> _fetchProfilePicture() async {
    // Assuming you have the current user's ID
    final currentUser = FirebaseAuth.instance.currentUser;

    // Fetch the user document to get the list of owned pet IDs
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser!.email).get();
    String fileName = userDoc['profileImage'];
    print("FILE NAME IS $fileName");
    if (fileName!=null) {
      try {
        final ref = FirebaseStorage.instance.ref().child('usersImages/$fileName');
        final url = await ref.getDownloadURL();
        print("STORAGE URL IS $url");
        setState(() {
          imageUrl = url;
        });
        print("URL IS $imageUrl");
      }  catch (e) {
        print(e);
      }
    }

  }



  @override
  Widget build(BuildContext context) {
    if (imageUrl==null) {
      return Image.asset("assets/images/no-image-image.png");
    } else {
      return Image.network(imageUrl);
    }
  }
}
