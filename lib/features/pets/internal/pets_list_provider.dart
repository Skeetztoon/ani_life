import 'package:ani_life/features/pets/data/repositories_impl/pets_list_repository_impl.dart';
import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petsListProvider = FutureProvider<List<PetModel>>((ref) async {
  final petsListRepositoryImpl = PetsLitsRepositoryIml();
  return await petsListRepositoryImpl.getPetsList();
});
