import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            String bio = userData["bio"];
            if (bio == "") {
              bio = "😎";
            }
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${userData["username"]}",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const Divider(),
                  (userData["bio"] != "")
                      ? Text(userData["bio"],
                          style: Theme.of(context).textTheme.titleSmall)
                      : Text(
                          "😎",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Произошла ошибка :("));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
