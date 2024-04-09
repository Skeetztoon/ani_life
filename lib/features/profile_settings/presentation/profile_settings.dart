import 'package:ani_life/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:ani_life/features/profile_settings/presentation/widgets/my_info_field.dart';
import 'package:ani_life/features/user_images/presentation/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountSettings extends ConsumerWidget {
  AccountSettings({super.key});

  final currentUser = FirebaseAuth.instance.currentUser;

  final usersCollection = FirebaseFirestore.instance.collection("users");

  Future<void> editField(
      BuildContext context, String hintTitle, String firebaseFieldName) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, child) {
          return AlertDialog(
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
                onPressed: () => Navigator.pop(context),
                child: const Text("Отменить"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(newValue);
                  if (newValue.trim().isNotEmpty) {
                    await usersCollection
                        .doc(currentUser!.email)
                        .update({firebaseFieldName: newValue});
                  }
                },
                child: const Text("Сохранить"),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      onPopInvoked: (didPop) {
        ref.read(profileViewModelProvider.notifier).loadData();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Настройки",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black),
          ),
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
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  // САМ КОНТЕНТ
                  children: [
                    const UserImage(),
                    const SizedBox(
                      height: 30,
                    ),
                    MyInfoField(
                      title: "Имя пользователя",
                      fieldValue: userData["username"].toString(),
                      onPressed: () =>
                          editField(context, "Укажите имя", "username"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyInfoField(
                      title: "О себе",
                      fieldValue: bio,
                      onPressed: () =>
                          editField(context, "Расскажите о себе", "bio"),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Произошла ошибка :("));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
