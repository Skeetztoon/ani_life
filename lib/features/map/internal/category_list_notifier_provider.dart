import 'package:ani_life/features/map/internal/category_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryListStateNotifierProvider =
    StateNotifierProvider<CategoryListStateNotifier, Set<String>>(
  (ref) => CategoryListStateNotifier(),
);
