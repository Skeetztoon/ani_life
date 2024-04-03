import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryListStateNotifier extends StateNotifier<Set<String>> {
  CategoryListStateNotifier() : super({});

  void addCategory(String category) {
    state = {...state, category};
  }

  void removeCategory(String category) {
    state = state.where((item) => item != category).toSet();
  }
}
