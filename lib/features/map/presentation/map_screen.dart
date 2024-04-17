import 'package:ani_life/features/map/presentation/widgets/my_yandex_map.dart';
import 'package:ani_life/features/search_bar/presentation/searchbar.dart';
import 'package:ani_life/features/map/presentation/widgets/chips_carousel.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Карта",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            // const Column(
            //   children: [
            //     MySearchBar(),
            //     Expanded(
            //       child:
            //         // MyMap(),
            //       MyYandexMap(),
            //     ),
            //   ],
            // ),
            const MyYandexMap(),
            const Positioned(top: 0, child: MySearchBar()),
            // SelectedCategories(),
            // FetchCategories(),
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: 50,
                width: width,
                child: const ChipCarousel(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
