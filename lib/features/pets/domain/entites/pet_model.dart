import 'package:flutter/material.dart';

class PetModel {
  PetModel({
    required this.petName,
    required this.petAge,
    this.imageColor,
  });

  final String petName;
  final int petAge;
  final Color? imageColor;
}
