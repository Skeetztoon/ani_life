import 'package:ani_life/extentions/string_extention.dart';
import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:flutter/material.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({super.key, required this.pet});

  final PetModel pet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Питомец",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Stack(
            // fit: StackFit.expand,
            children: [
              (pet.image.isNotEmpty)
                  ? Image.network(pet.image)
                  : Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.amber,
                    ),
              Positioned(
                right: 10,
                top: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => (),
                      //   ),
                      // );
                    },
                    icon: const Icon(
                      Icons.settings,
                      size: 30,
                      color: Color(0xFFCB6363),
                    ),
                  ),
                ),
              ),
            ],
          ),
          petDescription(context),
        ],
      ),
    );
  }

  Widget displayGender(BuildContext context, bool isMale) {
    return Icon(
      isMale ? Icons.male : Icons.female,
      size: 30,
    );
  }

  Widget displayTypeAndAge(
    BuildContext context,
    String type,
    bool isMale,
    int age,
  ) {
    String formatAge(int age) {
      if (age % 10 == 1 && age % 100 != 11) {
        return '$age год';
      } else if (age % 10 >= 2 &&
          age % 10 <= 4 &&
          (age % 100 < 10 || age % 100 >= 20)) {
        return '$age года';
      } else {
        return '$age лет';
      }
    }

    String res = "";
    switch (type) {
      case "dog":
        res = isMale ? "Пёс" : "Собака";
      case "cat":
        res = isMale ? "Кот" : "Кошка";
    }
    return Text(
      "${res.capitalize()} - ${formatAge(age)}",
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  Widget petDescription(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    pet.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  displayGender(context, pet.isMale),
                ],
              ),
              displayTypeAndAge(context, pet.type, pet.isMale, pet.age),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "О питомце",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(),
              Text(
                pet.bio.isNotEmpty ? pet.bio : "Описания пока нет",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
