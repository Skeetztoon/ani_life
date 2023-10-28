import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}



class _MyMapState extends State<MyMap> {

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
    return FlutterMap(
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
        // RichAttributionWidget(
        //   attributions: [
        //     TextSourceAttribution(
        //       'OpenStreetMap contributors',
        //       onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
