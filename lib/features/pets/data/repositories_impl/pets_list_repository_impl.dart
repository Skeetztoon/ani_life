import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:ani_life/features/pets/domain/repositories/pets_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

      List<String> images = List<String>.from(petDoc['images']);
      List<String> imagesLinks = [];
      if (images.isNotEmpty) {
        for (var image in images) {
          final imageLinkRef =
              FirebaseStorage.instance.ref().child('petsImages/$image');
          final imageLink = await imageLinkRef.getDownloadURL();
          imagesLinks.add(imageLink);
        }
      }
      pets.add(
        PetModel(
          id: petDoc.id,
          name: petDoc['name'],
          age: petDoc['age'],
          isMale: petDoc['gender'],
          images: imagesLinks,
          type: petDoc['type'],
          bio: petDoc['bio'] ?? "",
        ),
      );
    }

    return pets;
  }
}
