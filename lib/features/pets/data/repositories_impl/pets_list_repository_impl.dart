import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:ani_life/features/pets/domain/repositories/pets_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PetsLitsRepositoryIml extends PetsListRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<PetModel>> getPetsList() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(currentUser!.email).get();
    List<String> petIds = List<String>.from(userDoc['pets']);
    List<PetModel> pets = [];

    for (String petId in petIds) {
      DocumentSnapshot petDoc =
          await _firestore.collection('pets').doc(petId).get();
      pets.add(
        PetModel(
            name: petDoc['name'],
            age: petDoc['age'],
            isMale: petDoc['gender'],
            image: petDoc['image'] ?? "",
            type: petDoc['type'],
            bio: petDoc['bio'] ?? "",),
      );
    }

    return pets;
  }
}
