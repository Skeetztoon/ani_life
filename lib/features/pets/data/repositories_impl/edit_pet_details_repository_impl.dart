import 'dart:io';

import 'package:ani_life/features/pets/domain/repositories/edit_pet_details_repository.dart';
import 'package:ani_life/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

class EditPetDetailsRepositoryImpl extends EditPetDetailsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<String> addNewImage(String petId, String imagePath) async {
    late final String fileName;
    if (imagePath.isEmpty) {
      fileName = "";
    } else {
      fileName = DateTime.now().toIso8601String() + p.basename(imagePath);
      try {
        storage.FirebaseStorage.instance
            .ref()
            .child("petsImages")
            .child(fileName)
            .putFile(File(imagePath));
      } catch (e) {
        logger.log(Level.SEVERE, e);
        return "Произолша ошибка, попробуйте снова";
      }
    }
    try {
      await _firestore.collection("pets").doc(petId).update({
        'images': FieldValue.arrayUnion([fileName]),
      });
      return "Фото добавлено";
    } catch (e) {
      logger.log(Level.SEVERE, e);
      return "Произолша ошибка, попробуйте снова";
    }
  }
}
