import 'package:ani_life/features/pets/data/repositories_impl/pets_list_repository_impl.dart';
import 'package:ani_life/features/pets/domain/repositories/pets_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petsListProvider = Provider<PetsListRepository>((ref) => PetsLitsRepositoryIml());