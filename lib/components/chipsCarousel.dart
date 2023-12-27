import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Category {
  final String id;
  bool selected;

  Category(this.id, this.selected);
}

class CategoryNotifier extends StateNotifier<Category> {
  CategoryNotifier(String id) : super(Category(id, false));

  void toggleSelected() {
    state = Category(
      state.id,
      !state.selected,
    );
  }
}

final itemProvider = StateNotifierProvider.family<CategoryNotifier, Category, String>((ref, itemId) => CategoryNotifier(itemId));


class ChipCarousel extends ConsumerWidget {
  ChipCarousel({super.key});
  final List<String> categoryList = ["Магазины", "Клиники", "Передержка", "Приюты", "Площадки"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child:
          ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return Consumer(
                    builder: (context, ref, child) {
                      final item = ref.watch(itemProvider(categoryList[index]));
                      return
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilterChip(
                            label: Text(item.id),
                            selected: item.selected,
                            onSelected: (bool value) => ref.read(itemProvider(item.id).notifier).toggleSelected(),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: Color(0xFFF39191),
                                width: 2.0,
                              ),
                            ),
                            // avatar: const Text("A"),
                          ),
                        );
                    }
                );
              }
          )
      );
  }
}