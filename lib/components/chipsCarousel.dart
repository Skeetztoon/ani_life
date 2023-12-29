import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Category {
  final String id;
  final String categoryName;
  bool selected;

  Category(this.id, this.categoryName, this.selected);
}

class CategoryNotifier extends StateNotifier<Category> {
  CategoryNotifier(Category category)
      : super(Category(category.id, category.categoryName, false));

  void toggleSelected() {
    state = Category(
      state.id,
      state.categoryName,
      !state.selected,
    );
  }
}

final itemProvider =
    StateNotifierProvider.family<CategoryNotifier, Category, Category>(
        (ref, category) => CategoryNotifier(category));

final List<Category> categoryList = [
  Category("Магазины", "stores", false),
  Category("Клиники", "vets", false),
  Category("Передержка", "care", false),
  Category("Приюты", "shelters", false),
  Category("Площадки", "playground", false)
];

class ChipCarousel extends StatelessWidget {
  ChipCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return Consumer(builder: (context, ref, child) {
                final item = ref.watch(itemProvider(categoryList[index]));
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(item.id),
                    selected: item.selected,
                    onSelected: (bool value) => ref
                        .read(itemProvider(categoryList[index]).notifier)
                        .toggleSelected(),
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
              });
            }));
  }
}
