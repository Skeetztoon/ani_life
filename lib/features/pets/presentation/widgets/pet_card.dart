import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:ani_life/features/pets/presentation/screens/pet_screen.dart';
import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.pet,
  });

  final PetModel pet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetScreen(pet: pet),
          ),
        ); // TODO сделать экран питомца
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        // height: 250,
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.amber, // pet.petImage ??
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Text(
              pet.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "${pet.age} лет",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
