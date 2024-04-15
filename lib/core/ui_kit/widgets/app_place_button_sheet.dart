import 'package:flutter/material.dart';

class AppPlaceBottomSheet extends StatelessWidget {
  const AppPlaceBottomSheet({
    super.key,
    required this.placeName,
    required this.schedule,
    required this.address,
  });

  final String placeName;
  final String schedule;
  final String address;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      snapSizes: const [
        0.1,
        0.3,
      ],
      initialChildSize: 0.3, // Initial size of the bottom sheet
      minChildSize: 0.05, // Minimum size of the bottom sheet
      maxChildSize: 1, // Maximum size of the bottom sheet
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.white,
          child: ListView(
            controller: scrollController, // Use the provided ScrollController
            children: [
              const SizedBox(height: 15),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  height: 8,
                  width: 120,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                placeName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Адрес: $address",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 10),
              Text(
                "График работы: $schedule",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
              Container(height: 300, color: Colors.red),
              Container(height: 300, color: Colors.blue),
              Container(height: 300, color: Colors.green),
            ],
          ),
        );
      },
    );
  }
}
