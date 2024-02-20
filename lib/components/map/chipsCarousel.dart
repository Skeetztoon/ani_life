import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Category model
class Category {
  final String id;
  final String categoryName;
  final bool selected;

  Category(this.id, this.categoryName, this.selected);
}

final categoryNotifierProvider =
    StateNotifierProvider.family<CategoryNotifier, Category, Category>(
        (ref, categoryId) => CategoryNotifier(categoryId));

class CategoryNotifier extends StateNotifier<Category> {
  CategoryNotifier(Category category)
      : super(Category(category.id, category.categoryName, category.selected));

  void toggleSelected() {
    state = Category(
      state.id,
      state.categoryName,
      !state.selected,
    );
  }
}

// список кнопок категорий
final List<Category> categoryList = [
  Category("Магазины", "stores", false),
  Category("Клиники", "vets", false),
  Category("Передержка", "care", false),
  Category("Приюты", "shelters", false),
  Category("Площадки", "playground", false)
];

class ChipCarousel extends StatelessWidget {
  const ChipCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return Consumer(builder: (context, ref, child) {
                final item =
                    ref.watch(categoryNotifierProvider(categoryList[index]));
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(item.id,),
                    selected: item.selected,
                    onSelected: (bool value) {
                      ref
                        .read(categoryNotifierProvider(categoryList[index])
                            .notifier)
                        .toggleSelected();
                      if (value) {
                        ref
                            .read(categoryListStateNotifierProvider.notifier)
                            .addCategory(item.categoryName);
                      } else {
                        ref
                            .read(categoryListStateNotifierProvider.notifier)
                            .removeCategory(item.categoryName);
                      }
                    },
                    selectedColor: Colors.grey.shade200,
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

final categoryListStateNotifierProvider =
    StateNotifierProvider<CategoryListStateNotifier, Set<String>>(
        (ref) => CategoryListStateNotifier());

class CategoryListStateNotifier extends StateNotifier<Set<String>> {
  CategoryListStateNotifier() : super({});

  void addCategory(String category) {
    state = {...state, category};
  }

  void removeCategory(String category) {
    state = state.where((item) => item != category).toSet();
  }
}

class SelectedCategories extends ConsumerWidget {
  const SelectedCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.watch(categoryListStateNotifierProvider);
    return Column(
      children: [
        ...categoryList.map((item) => Text(item)),
      ],
    );
  }
}
