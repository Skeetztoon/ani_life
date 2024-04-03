import 'package:flutter/material.dart';

class PlaceBottomSheet extends StatelessWidget {
  final String placeName;
  final String schedule;
  final String address;

  const PlaceBottomSheet({
    super.key,
    required this.placeName,
    required this.schedule,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          builder: (BuildContext context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      placeName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "График работы: $schedule",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Адрес: $address",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: const FlutterLogo(),
    );
  }
}
