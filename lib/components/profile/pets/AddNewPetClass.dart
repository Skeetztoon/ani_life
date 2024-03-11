import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNewPet {
  final String petName;
  final int? petAge;

  AddNewPet({required this.petName, this.petAge});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> createNewPet() async {
    try {
      await _firestore.collection("pets").add({
        "name": this.petName,
        "age": this.petAge?? "",
        "images": [],
        "gender": false,
      }).then((documentSnapshot) => _firestore
          .collection("users")
          .doc(currentUser!.email)
          .update({"pets": FieldValue.arrayUnion(["${documentSnapshot.id}"])}));
      print("Животина добавлена");
    } catch (e) {
      print(e);
    }
  }
}

