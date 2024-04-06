import 'package:ani_life/features/map/domain/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends StateNotifier<Category> {
  CategoryNotifier(Category category) : super(category);

  void toggleSelected() {
    state = Category(
      state.id,
      state.categoryName,
      !state.selected,
    );
  }
}
