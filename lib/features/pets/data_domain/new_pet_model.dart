import 'package:ani_life/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

class AddNewPet {
  final String petName;
  final int? petAge;

  AddNewPet({required this.petName, this.petAge});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> createNewPet() async {
    try {
      await _firestore.collection("pets").add({
        "name": petName,
        "age": petAge ?? "",
        "images": [],
        "gender": false,
      }).then(
        (documentSnapshot) =>
            _firestore.collection("users").doc(currentUser!.email).update({
          "pets": FieldValue.arrayUnion([(documentSnapshot.id)])
        }),
      );
      logger.log(Level.FINE, "Животина добавлена");
    } catch (e) {
      logger.log(Level.SEVERE, e);
    }
  }
}
