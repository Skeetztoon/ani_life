import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chipsCarousel.dart';
import 'fetch_categories.dart';
import 'map/place_model.dart';

// List<List<double>> points = [
//   [55.751244, 37.618423],
//   [55.751244, 37.698423],
//   [55.711224, 37.658443]
// ];

List<Marker> myMarkers(List<Place> placesList) {
  List<Marker> myMarkersList = [];
  for (var i = 0; i < placesList.length; i++) {
    double lat = placesList[i].coords[0];
    double lon = placesList[i].coords[1];
    Marker m = Marker(
        point: LatLng(lat, lon), width: 30, height: 30, child: FlutterLogo());
    myMarkersList.add(m);
  }
  return myMarkersList;
}

class MyMap extends ConsumerWidget {
  const MyMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MapController mapController = MapController();

    final categoryList = ref.watch(categoryListStateNotifierProvider);
    return Stack(children: [
      FlutterMap(
          mapController: mapController,
          options: const MapOptions(
            initialCenter: LatLng(55.751244, 37.618423),
            initialZoom: 9.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
                markers: ref
                    .watch(selectedCategoriesDataProvider(categoryList))
                    .when(
                        data: (data) => myMarkers(data),
                        error: (_, __) => [],
                        loading: () => [])),
          ]),
      Positioned(
        bottom: 300,
        right: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)), //<-- SEE HERE
                child: InkWell(
                  onTap: () async {
                    var currentZoomLevel = await mapController.zoom;
                    currentZoomLevel += 0.5;
                    if (currentZoomLevel < 0) currentZoomLevel = 0;
                    mapController.move(mapController.center, currentZoomLevel);
                  },
                  child: Icon(
                    Icons.add,
                    size: 40.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)), //<-- SEE HERE
                child: InkWell(
                  onTap: () async {
                    var currentZoomLevel = await mapController.zoom;
                    currentZoomLevel -= 0.5;
                    if (currentZoomLevel < 0) currentZoomLevel = 0;
                    mapController.move(mapController.center, currentZoomLevel);
                  },
                  child: Icon(
                    Icons.remove,
                    size: 40.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
