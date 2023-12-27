import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  MapController mapController = MapController();

  // void _onMapCreated(MapController controller) {
  //   mapController = controller;
  // }



  List<List<double>> points = [
    [55.751244, 37.618423],
    [55.751244, 37.698423],
    [55.711224, 37.658443]
  ];

  List<Marker> myMarkers(List<List<double>> points) {
    List<Marker> myMarkersList = [];
    for (var i = 0; i < points.length; i++) {
      double lat = points[i][0];
      double lon = points[i][1];
      Marker m = Marker(
          point: LatLng(lat, lon), width: 30, height: 30, child: FlutterLogo());
      myMarkersList.add(m);
    }
    return myMarkersList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(55.751244, 37.618423),
          initialZoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
              markers:
              myMarkers(points)
            // Marker(
            //   point: LatLng(55.751244, 37.618423),
            //   width: 30,
            //   height: 30,
            //   child: FlutterLogo(),
            // ),

          ),
        ],
      ),
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
      ]
    );
  }
}
