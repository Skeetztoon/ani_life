import 'package:ani_life/core/ui_kit/widgets/app_place_button_sheet.dart';
import 'package:ani_life/features/map/domain/place_model.dart';
import 'package:ani_life/features/map/internal/category_list_notifier_provider.dart';
import 'package:ani_life/features/map/internal/places_by_categories_provider.dart';
import 'package:ani_life/features/map/presentation/widgets/filters_widget.dart';
import 'package:ani_life/main.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

late final YandexMapController mapController;

class MyYandexMap extends ConsumerStatefulWidget {
  const MyYandexMap({super.key});
  @override
  ConsumerState<MyYandexMap> createState() => _MyYandexMapState();
}

class _MyYandexMapState extends ConsumerState<MyYandexMap> {
  @override
  Widget build(BuildContext context) {
    List<PlacemarkMapObject> myPlacemarks(
        List<Place> placesList, BuildContext context) {
      List<PlacemarkMapObject> myPlacemarksList = [];
      for (var i = 0; i < placesList.length; i++) {
        double lat = placesList[i].coords[0];
        double lon = placesList[i].coords[1];
        PlacemarkMapObject placemarkMapObject = PlacemarkMapObject(
          mapId: MapObjectId('placemark_$i'),
          point: Point(
            latitude: lat,
            longitude: lon,
          ),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image:
                  BitmapDescriptor.fromAssetImage('lib/assets/icons/place.png'),
            ),
          ),
          text: const PlacemarkText(
            text: 'Point',
            style: PlacemarkTextStyle(
              placement: TextStylePlacement.top,
              color: Colors.amber,
              outlineColor: Colors.black,
            ),
          ),
          onTap: (_, point) async {
            // mapController.move(markerPosition, 15.5);
            await mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: Point(
                      latitude: point.latitude, longitude: point.longitude),
                  zoom: 15.5,
                ),
              ),
            );
            if (context.mounted) {
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
                    placeName: placesList[i].name,
                    schedule: placesList[i].schedule,
                    address: placesList[i].place,
                  );
                },
              );
            }
          },
        );
        myPlacemarksList.add(placemarkMapObject);
        logger.log(Level.FINE, "ADDED PLACE TO LIST");
      }
      logger.log(Level.FINE, myPlacemarksList);
      return myPlacemarksList;
    }

    final categoryList = ref.watch(categoryListStateNotifierProvider);
    List<PlacemarkMapObject> placesList = ref
        .watch(
          placesByCategoriesProvider(
            categoryList,
          ),
        ) // берем из провайдера список
        .when(
          data: (data) => myPlacemarks(data, context), // получаем лист маркеров
          error: (_, __) => [],
          loading: () => [],
        );

    return Stack(
      children: [
        YandexMap(
          mapObjects: placesList,
          logoAlignment: const MapAlignment(
            horizontal: HorizontalAlignment.left,
            vertical: VerticalAlignment.top,
          ),
          onMapCreated: (controller) async {
            mapController = controller;
            await mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                const CameraPosition(
                  target: Point(latitude: 55.751244, longitude: 37.618423),
                  zoom: 12,
                ),
              ),
            );
          },
        ),
        const Positioned(
          top: 10,
          right: 10,
          child: FiltersButton(),
        ),
        Positioned(
          // кнопки зума
          bottom: MediaQuery.of(context).size.height * 0.3,
          right: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              zoomButton(context, true),
              const SizedBox(
                height: 5,
              ),
              zoomButton(context, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget zoomButton(BuildContext context, bool zoomIn) {
    return InkWell(
      onTap: () async {
        (zoomIn)
            ? await mapController.moveCamera(CameraUpdate.zoomIn())
            : await mapController.moveCamera(CameraUpdate.zoomOut());
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
          zoomIn ? Icons.add : Icons.remove,
          color: Colors.grey.shade400,
          size: 40,
        ),
      ),
    );
  }
}

// class ZoomButton extends StatelessWidget {
//   const ZoomButton({super.key, required this.controller, required this.zoomIn});
//
//   final YandexMapController controller;
//   final bool zoomIn;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         (zoomIn)?
//         await controller.moveCamera(CameraUpdate.zoomIn()):
//         await controller.moveCamera(CameraUpdate.zoomOut());;
//       },
//       child: Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.85),
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.25),
//               blurRadius: 2,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(zoomIn?
//           Icons.add:Icons.remove,
//           color: Colors.grey.shade400,
//           size: 40,
//         ),
//       ),
//     );
//   }
// }

class FiltersButton extends StatelessWidget {
  const FiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            return const FiltersWidget();
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
    );
  }
}
