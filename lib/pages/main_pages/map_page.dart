import 'package:ani_life/components/chipsCarousel.dart';
import 'package:ani_life/components/fetch_categories.dart';
import 'package:ani_life/components/my_map.dart';
import 'package:ani_life/components/my_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //sign user out
  // void signOut() {
  //   // get auth service
  //   final authService = Provider.of<AuthService>(context, listen: false);
  //   authService.signOut();
  // }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Карта",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black)),
      ),
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            MyMap(),
            // SelectedCategories(),
            // FetchCategories(),
            Positioned(top: 0, child: MySearchBar()),
            Positioned(bottom: 0, child: SizedBox(height: 50, width: width, child: ChipCarousel())),
          ],
        ),
      ),
    );
  }
}