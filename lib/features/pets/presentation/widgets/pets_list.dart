import 'package:ani_life/features/pets/presentation/adding_new_pet_screen.dart';
import 'package:ani_life/features/pets/presentation/widgets/pet_card.dart';
import 'package:ani_life/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key});

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<DocumentSnapshot> _pets = [];

  @override
  void initState() {
    super.initState();
    _fetchPets();
  }

  Future<void> _fetchPets() async {
    // Assuming you have the current user's ID
    final currentUser = FirebaseAuth.instance.currentUser;

    // Fetch the user document to get the list of owned pet IDs
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(currentUser!.email).get();
    List<String> petIds = List<String>.from(userDoc['pets']);

    // Fetch each pet document by ID
    for (String petId in petIds) {
      DocumentSnapshot petDoc =
          await _firestore.collection('pets').doc(petId).get();
      setState(() {
        _pets.add(petDoc);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: _pets.isEmpty
                ? const ContainerToAddNewPet()
                : Row(
                    children: [
                      ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _pets.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 12,
                          );
                        },
                        itemBuilder: (context, index) {
                          return PetCard(
                            petName: _pets[index]["name"],
                            petAge: _pets[index]["age"],
                            imageColor: Colors.amber,
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
