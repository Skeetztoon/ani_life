import 'package:ani_life/features/pets/domain/entites/pet_model.dart';

abstract class PetsListRepository {
  Future<List<PetModel>> getPetsList();
}
