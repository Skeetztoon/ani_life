import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';

class PlaceMarkerWidget extends StatelessWidget {
  final String placeName;
  final String schedule;
  final String address;

  const PlaceMarkerWidget(
      {super.key,
      required this.placeName,
      required this.schedule,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder( // <-- SEE HERE
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              builder: (BuildContext context) {
                return SizedBox(
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(placeName, style: Theme.of(context).textTheme.titleLarge,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("График работы: $schedule", style: Theme.of(context).textTheme.titleMedium),
                    ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Адрес: $address", style: Theme.of(context).textTheme.titleMedium),
                      ),
                  ],),
                );
              });
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(
          //         "$placeName \nГрафик работы: $schedule \n Адрес: $address"),
          //   ),
          // );
        },
        icon: FlutterLogo());
  }
  //
  // Widget _bottomDrawer(BuildContext context) {
  //   return BottomDrawer(header: Container(), body: Container(), headerHeight: 60.0, drawerHeight: 180.0, controller: _controller,);
  // }
}
