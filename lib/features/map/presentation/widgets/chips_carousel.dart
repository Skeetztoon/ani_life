import 'package:ani_life/features/map/domain/category_list.dart';
import 'package:ani_life/features/map/internal/category_list_notifier_provider.dart';
import 'package:ani_life/features/map/internal/category_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChipCarousel extends StatelessWidget {
  // сам виджет карусели
  const ChipCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return Consumer(
            builder: (context, ref, child) {
              final item =
                  ref.watch(categoryNotifierProvider(categoryList[index]));
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(
                    item.id,
                  ),
                  selected: item.selected,
                  onSelected: (bool value) {
                    ref
                        .read(
                          categoryNotifierProvider(categoryList[index])
                              .notifier,
                        )
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
                    side: const BorderSide(
                      color: Color(0xFFF39191),
                      width: 2.0,
                    ),
                  ),
                  // avatar: const Text("A"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Вывод списка категорий для дебага

// class SelectedCategories extends ConsumerWidget {
//   const SelectedCategories({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final categoryList = ref.watch(categoryListStateNotifierProvider);
//     return Column(
//       children: [
//         ...categoryList.map((item) => Text(item)),
//       ],
//     );
//   }
// }
