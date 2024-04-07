import 'package:ani_life/features/pets/internal/pets_list_provider.dart';
import 'package:ani_life/features/pets/presentation/adding_new_pet_screen.dart';
import 'package:ani_life/features/pets/presentation/widgets/pet_card.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PetsList extends ConsumerWidget {
  const PetsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petAsyncValue = ref.watch(petsListProvider);

    return petAsyncValue.when(
      data: (pets) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        height: 260,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: aniColorLight,
            ),
            padding: const EdgeInsets.all(8),
            // height: 300,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: pets.isEmpty
                  ? const ContainerToAddNewPet()
                  : Row(
                      children: [
                        ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: pets.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 12,
                            );
                          },
                          itemBuilder: (context, index) {
                            return PetCard(
                              petName: pets[index].petName,
                              petAge: pets[index].petAge,
                              imageColor: pets[index].imageColor,
                            );
                          },
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const ContainerToAddNewPet(),
                      ],
                    ),
            ),
          ),
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

class ContainerToAddNewPet extends StatelessWidget {
  const ContainerToAddNewPet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: IconButton(
        icon: const Icon(Icons.add_circle),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddingNewPetScreen(),
            ),
          );
        },
      ),
    );
  }
}
