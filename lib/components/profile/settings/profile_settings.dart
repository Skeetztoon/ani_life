import 'package:ani_life/components/profile/settings/myInfoField.dart';
import 'package:ani_life/components/profile/images/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection("users");

  String imageUrl = "";

  Future<void> editField(String hintTitle, String firebaseFieldName) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text(""),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: hintTitle,
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Отменить")),
          TextButton(
              onPressed: () async {
                Navigator.of(context).pop(newValue);
                if (newValue.trim().length > 0) {
                  await usersCollection
                      .doc(currentUser!.email)
                      .update({firebaseFieldName: newValue});
                }
              },
              child: Text("Сохранить")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 35, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Настройки",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black)),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              String bio = userData['bio'];
              if (bio == "") {
                bio = "О себе";
              }
              return Container(
                padding: EdgeInsets.all(20),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // САМ КОНТЕНТ
                  children: [
                    UserImage(
                      onFileChanged: (imageUrl) {
                        setState(() {
                          this.imageUrl = imageUrl;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    myInfoField(
                      title: "Имя пользователя",
                      fieldValue: userData["username"].toString(),
                      onPressed: () => editField("Укажите имя", "username"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    myInfoField(
                      title: "О себе",
                      fieldValue: bio,
                      onPressed: () => editField("Расскажите о себе", "bio"),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Произошла ошибка :("));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
