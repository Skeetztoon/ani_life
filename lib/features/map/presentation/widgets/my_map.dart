import 'package:ani_life/core/ui_kit/filters_page.dart';
import 'package:ani_life/features/map/domain/place_model.dart';
import 'package:ani_life/features/map/internal/category_list_notifier_provider.dart';
import 'package:ani_life/features/map/internal/places_by_categories_provider.dart';
import 'package:ani_life/features/map/presentation/widgets/place_mark.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

MapController mapController = MapController();

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
      child: PlaceMark(
        placeName: placesList[i].name,
        schedule: placesList[i].schedule,
        address: placesList[i].place,
        markerPosition: LatLng(lat, lon),
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
            initialZoom: 10.2,
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            ),
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
                    .watch(
                      placesByCategoriesProvider(
                        categoryList,
                      ),
                    ) // берем из провайдера список
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
          top: 80,
          right: 10,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                useSafeArea: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                  ),
                ),
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const FiltersPage();
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.85),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.layers_rounded,
                color: aniColorPrimary,
                size: 40,
              ),
            ),
          ),
        ),
        Positioned(
          // кнопки зума
          bottom: MediaQuery.of(context).size.height * 0.3,
          right: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  var currentZoomLevel = mapController.camera.zoom;
                  currentZoomLevel += 0.5;
                  if (currentZoomLevel < 0) currentZoomLevel = 0;
                  mapController.move(
                    mapController.camera.center,
                    currentZoomLevel,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.grey.shade400,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  var currentZoomLevel = mapController.camera.zoom;
                  currentZoomLevel -= 0.5;
                  if (currentZoomLevel < 0) currentZoomLevel = 0;
                  mapController.move(
                    mapController.camera.center,
                    currentZoomLevel,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.grey.shade400,
                    size: 40,
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
