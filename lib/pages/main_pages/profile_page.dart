import 'package:ani_life/components/my_searchbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("События",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black)),
      ),
      body: Center(
        child: MySearchBar(),
      ),
    );
  }
}
