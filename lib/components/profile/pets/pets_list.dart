import 'package:ani_life/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key});

  @override
  State<PetsList> createState() => _PetsListState();
}

class Pet {
  final String name;
  final Color imageColor;
  Pet({required this.name, required this.imageColor});
}

List<Pet> pets = [
  Pet(name: "Буся", imageColor: Colors.blue),
  Pet(name: "Пуся", imageColor: Colors.yellow),
];

class _PetsListState extends State<PetsList> {

  int _focusedIndex = 0;
  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AniColorLight,
          ),
          padding: EdgeInsets.all(8),
          // height: 300,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: pets.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12,);
                  },
                  itemBuilder: (context, index) {
                    return PetCard(petName: pets[index].name, imageColor: Colors.amber,);
                  },
                ),

                SizedBox(width: 12,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: IconButton(icon: Icon(Icons.add_circle), onPressed: () {},),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  const PetCard({super.key, required this.petName, this.imageColor});

  final String petName;
  final Color? imageColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      // height: 250,
      child: Column(
        children: [
          Container(width: 150, height: 150, decoration: BoxDecoration(
            color: imageColor?? Colors.deepOrange,
            borderRadius: BorderRadius.circular(15)
          ),),

          Text(
            petName,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
