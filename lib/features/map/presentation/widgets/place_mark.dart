import 'package:ani_life/core/ui_kit/widgets/app_place_button_sheet.dart';
import 'package:ani_life/features/map/presentation/widgets/my_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class PlaceMark extends StatelessWidget {
  final String placeName;
  final String schedule;
  final String address;
  final LatLng markerPosition;

  const PlaceMark({
    super.key,
    required this.placeName,
    required this.schedule,
    required this.address,
    required this.markerPosition,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        mapController.move(markerPosition, 15.5);
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          useSafeArea: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          builder: (BuildContext context) {
            return AppPlaceBottomSheet(
              placeName: placeName,
              schedule: schedule,
              address: address,
            );
          },
        );
      },
      icon: const FlutterLogo(),
    );
  }
}
