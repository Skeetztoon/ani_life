import 'package:ani_life/features/map/domain/category_list.dart';
import 'package:ani_life/features/map/internal/category_list_notifier_provider.dart';
import 'package:ani_life/features/map/internal/category_notifier_provider.dart';
import 'package:flutter/material.dart ';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersPage extends ConsumerStatefulWidget {
  const FiltersPage({super.key});

  @override
  ConsumerState<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends ConsumerState<FiltersPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blueGrey,
                ),
                height: 8,
                width: 120,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Фильтры",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Услуги",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Wrap(
              children: [
                Chip(id: 1),
                Chip(id: 4),
                Chip(
                  id: 5,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 20),
              child: Text(
                "Места",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Wrap(
              children: [
                Chip(id: 6),
                Chip(id: 7),
                Chip(
                  id: 8,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 20),
              child: Text(
                "Магазины",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Wrap(
              children: [
                Chip(id: 0),
                Chip(id: 9),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Chip extends StatelessWidget {
  const Chip({super.key, required this.id});

  final int id;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final item = ref.watch(
          categoryNotifierProvider(categoryList[id]),
        );
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
                    categoryNotifierProvider(categoryList[id]).notifier,
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
  }
}
