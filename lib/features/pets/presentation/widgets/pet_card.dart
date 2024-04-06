import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.petName,
    required this.petAge,
    this.imageColor,
  });

  final String petName;
  final int petAge;
  final Color? imageColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print("Ето контаинер $petName'а"); // TODO сделать экран питомца
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        // height: 250,
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: imageColor ?? Colors.deepOrange,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Text(
              petName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "$petAge лет",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
