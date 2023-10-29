import 'package:ani_life/components/chipsCarousel.dart';
import 'package:ani_life/components/myChipFilter.dart';
import 'package:ani_life/components/my_map.dart';
import 'package:ani_life/components/my_searchbar.dart';
import 'package:ani_life/main.dart';
import 'package:ani_life/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //sign user out
  void signOut() {
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Карта",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(
              Icons.logout,
              size: 35,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            MySearchBar(),
            MyMap(),
            Positioned(bottom: 0, child: ChipCarousel()),
          ],
        ),
      ),
    );
  }
}
