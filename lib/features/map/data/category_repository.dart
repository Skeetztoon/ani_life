import 'package:ani_life/features/map/domain/place_model.dart';

abstract class CategoryRepository {
  Future<List<Place>> fetchPlacesByCategory(String categoryName);
  Future<List<Place>> fetchPlacesByCategories(Set<String> categories);
}
