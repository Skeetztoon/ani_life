import 'package:ani_life/features/map/data/category_fetch_service.dart';
import 'package:ani_life/features/map/data/category_repository.dart';

import 'package:ani_life/features/map/domain/place_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryFetchService _categoryFetchService;

  CategoryRepositoryImpl(this._categoryFetchService);

  @override
  Future<List<Place>> fetchPlacesByCategory(String categoryName) async {
    return await _categoryFetchService.fetchPlacesByCategory(categoryName);
  }

  @override
  Future<List<Place>> fetchPlacesByCategories(Set<String> categories) async {
    return await _categoryFetchService.fetchPlacesByCategories(categories);
  }
}
