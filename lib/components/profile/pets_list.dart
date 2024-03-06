import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key});

  @override
  State<PetsList> createState() => _PetsListState();
}

final currentUser = FirebaseAuth.instance.currentUser;

class _PetsListState extends State<PetsList> {
  // final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final pets = userData["pets"];
            return Container();
          } else if (snapshot.hasError) {
            return const Center(child: Text("Произошла ошибка :("));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future<void> createNewPet(String name, String? image, String gender, int age,
    BuildContext context) async {
  try {
    _firestore.collection("pets").add({
      "petname": name,
      "petimages": [image],
      "gender": gender,
      "age": age
    }).then((documentSnapshot) => _firestore
        .collection("users")
        .doc(currentUser!.email)
        .update({"pets": FieldValue.arrayUnion(["${documentSnapshot.id}"])}));
    // _firestore.collection("users").doc(currentUser!.email).update({"pets": []});
  } catch (e) {
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: const Text('Error Occured'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("OK"))
                ]));
  } catch (e) {
    print(e);
  }
}
