import 'package:ani_life/components/profile/credentials/profileDetails.dart';
import 'package:ani_life/components/profile/pets/pets_list.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/profile/credentials/profile_settings.dart';
import '../../services/auth/auth_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late DocumentSnapshot userDocument;
  //
  // Future<void> getCurrentUserDocument() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     userDocument = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .get();
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUserDocument();
  // }
  //
  // Future setProfilePicture() async {
  //   final _selectedPicture = await ImagePicker().pickImage(source: ImageSource.gallery);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Профиль",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black)),
        actions: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final auth = ref.watch(authenticationProvider);
              return IconButton(
                onPressed: () => auth.signOut(),
                icon: const Icon(
                  Icons.logout,
                  size: 35,
                  color: Colors.black,
                ),
              );
            },
          ),
        ],
      ),
      // body: Center(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         Container(
      //           height: MediaQuery.of(context).size.width,
      //           color: Colors.blue,
      //         ),
      //         ProfileDetails(),
      //         PetsList(),
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const AccountSettings()),
      //     );
      //   },
      //   foregroundColor: AniColorPrimary,
      //   backgroundColor: Colors.white,
      //   child: const Icon(Icons.settings),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: false,
            expandedHeight: MediaQuery.of(context).size.width,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(fit: StackFit.expand, children: [
                const ColoredBox(
                  color: Colors.blueAccent,
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountSettings()),
                        );
                      },
                      icon: const Icon(Icons.settings, size: 30, color: Color(0xFFCB6363),),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ProfileDetails(),
              PetsList(),
            ]),
          ),
        ],
      ),
    );
  }
}
