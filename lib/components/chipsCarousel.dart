import 'package:ani_life/components/myChipFilter.dart';
import 'package:flutter/material.dart';

class ChipCarousel extends StatefulWidget {
  const ChipCarousel({super.key});

  @override
  State<ChipCarousel> createState() => _ChipCarouselState();
}

class _ChipCarouselState extends State<ChipCarousel> {
  final List categories = ["Магазины", "Клиники", "Передержка", "Приюты", "Площадки"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return MyChipFilter(
              lbl: categories[index],
            );
          }),
    );
  }
}
