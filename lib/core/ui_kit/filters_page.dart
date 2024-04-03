import 'package:ani_life/core/ui_kit/widgets/my_chip_filter.dart';
import 'package:flutter/material.dart ';

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                MyChipFilter(lbl: "Груминг"),
                MyChipFilter(lbl: "Ветклиника"),
                MyChipFilter(lbl: "Кинологические центры"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
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
                MyChipFilter(lbl: "Развлечения"),
                MyChipFilter(lbl: "Площадки для выгула"),
                MyChipFilter(lbl: "Кафе и рестораны"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
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
                MyChipFilter(lbl: "Товары для кошек и собак"),
                MyChipFilter(lbl: "Одежда"),
                MyChipFilter(lbl: "Товары для грызунов"),
                MyChipFilter(lbl: "Товары для экзотических животных"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
