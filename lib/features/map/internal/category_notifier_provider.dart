import 'package:ani_life/features/map/domain/category_model.dart';
import 'package:ani_life/features/map/internal/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryNotifierProvider =
    StateNotifierProvider.family<CategoryNotifier, Category, Category>(
  (ref, categoryId) => CategoryNotifier(categoryId),
);
