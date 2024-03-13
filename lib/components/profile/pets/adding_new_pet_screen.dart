import 'package:ani_life/components/profile/pets/new_pet_model.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';

class AddingNewPetScreen extends StatefulWidget {
  const AddingNewPetScreen({super.key});

  @override
  State<AddingNewPetScreen> createState() => _AddingNewPetScreenState();
}

class _AddingNewPetScreenState extends State<AddingNewPetScreen> {
  TextEditingController _petNameController = TextEditingController();
  TextEditingController _petAgeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _petNameController,
                  decoration: InputDecoration(
                    hintText: "Как зовут вашего питомца?",
                  ),
                ),

                TextField(
                  controller: _petAgeController,
                  decoration: InputDecoration(
                    hintText: "Сколько лет вашему питомцу?",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.male)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.female)),
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
                            color: AniColorLight,
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
                          await AddNewPet(petName: _petNameController.text, petAge: int.parse(_petAgeController.text)).createNewPet();
                          Navigator.pop(context);
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
      ),
    );
  }
}
