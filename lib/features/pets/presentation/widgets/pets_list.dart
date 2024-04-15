import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:ani_life/features/pets/presentation/screens/adding_new_pet_screen.dart';
import 'package:ani_life/features/pets/presentation/widgets/pet_card.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PetsList extends ConsumerWidget {
  const PetsList(this.pets, {super.key});

  final List<PetModel> pets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
                            pet: pets[index],
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
