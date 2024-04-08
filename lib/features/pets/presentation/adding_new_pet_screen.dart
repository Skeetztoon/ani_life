import 'package:ani_life/features/pets/data/new_pet_model.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';

class AddingNewPetScreen extends StatefulWidget {
  const AddingNewPetScreen({super.key});

  @override
  State<AddingNewPetScreen> createState() => _AddingNewPetScreenState();
}

class _AddingNewPetScreenState extends State<AddingNewPetScreen> {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petAgeController = TextEditingController();

  @override
  void dispose() {
    _petNameController.dispose();
    _petAgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _petNameController,
                decoration: const InputDecoration(
                  hintText: "Как зовут вашего питомца?",
                ),
              ),
              TextField(
                controller: _petAgeController,
                decoration: const InputDecoration(
                  hintText: "Сколько лет вашему питомцу?",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.male)), //TODO сделать выбор пола
                  IconButton(onPressed: () {}, icon: const Icon(Icons.female)),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: aniColorLight,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        await AddNewPet(
                          petName: _petNameController.text,
                          petAge: int.parse(_petAgeController.text),
                        ).createNewPet();
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Добавить'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
