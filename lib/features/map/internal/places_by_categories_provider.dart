import 'package:ani_life/features/map/data/category_fetch_service.dart';
import 'package:ani_life/features/map/data/category_repository.dart';
import 'package:ani_life/features/map/data/category_repository_impl.dart';
import 'package:ani_life/features/map/domain/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl(CategoryFetchService());
});

final placesByCategoriesProvider = FutureProvider.autoDispose
    .family<List<Place>, Set<String>>((ref, selectedCategoriesSet) async {
  final categoryRepository = ref.watch(
    categoryRepositoryProvider,
  ); // Assuming you have a way to access FirebaseService
  return await categoryRepository
      .fetchPlacesByCategories(selectedCategoriesSet);
});
