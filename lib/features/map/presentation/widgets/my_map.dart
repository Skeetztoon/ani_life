import 'package:ani_life/features/map/domain/place_model.dart';
import 'package:ani_life/features/map/internal/category_list_notifier_provider.dart';
import 'package:ani_life/features/map/internal/places_by_categories_provider.dart';
import 'package:ani_life/features/map/presentation/widgets/place_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Marker> myMarkers(List<Place> placesList) {
  // конвертим из списка мест в список координат
  List<Marker> myMarkersList = [];
  for (var i = 0; i < placesList.length; i++) {
    double lat = placesList[i].coords[0];
    double lon = placesList[i].coords[1];
    Marker m = Marker(
      point: LatLng(lat, lon),
      width: 50,
      height: 50,
      child: PlaceBottomSheet(
        placeName: placesList[i].name,
        schedule: placesList[i].schedule,
        address: placesList[i].place,
      ),
    );
    myMarkersList.add(m);
  }
  return myMarkersList;
}

class MyMap extends ConsumerStatefulWidget {
  const MyMap({super.key});
  @override
  ConsumerState<MyMap> createState() => _MyMapState();
}

class _MyMapState extends ConsumerState<MyMap> {
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final categoryList = ref.watch(categoryListStateNotifierProvider);
    return Stack(
      children: [
        FlutterMap(
          // карта
          mapController: mapController,
          options: const MapOptions(
            initialCenter: LatLng(55.751244, 37.618423),
            initialZoom: 9.2,
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                // maxClusterRadius: 100,
                size: const Size(30, 30),
                // anchor: AnchorPos.align(AnchorAlign.center),
                // fitBoundsOptions: const FitBoundsOptions(
                //   padding: EdgeInsets.all(50),
                //   maxZoom: 15,
                // ),
                // spiderfySpiralDistanceMultiplier: 2,
                // spiderfyCircleRadius: 20,
                markers: ref
                    .watch(placesByCategoriesProvider(
                        categoryList)) // берем из провайдера список
                    .when(
                      data: (data) => myMarkers(data), // получаем лист маркеров
                      error: (_, __) => [],
                      loading: () => [],
                    ),
                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          // кнопки зума
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
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () async {
                      var currentZoomLevel = mapController.camera.zoom;
                      currentZoomLevel += 0.5;
                      if (currentZoomLevel < 0) currentZoomLevel = 0;
                      mapController.move(
                          mapController.camera.center, currentZoomLevel);
                    },
                    child: Icon(
                      Icons.add,
                      size: 40.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () async {
                      var currentZoomLevel = mapController.camera.zoom;
                      currentZoomLevel -= 0.5;
                      if (currentZoomLevel < 0) currentZoomLevel = 0;
                      mapController.move(
                          mapController.camera.center, currentZoomLevel);
                    },
                    child: Icon(
                      Icons.remove,
                      size: 40.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
