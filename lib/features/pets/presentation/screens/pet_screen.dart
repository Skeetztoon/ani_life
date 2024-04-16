import 'dart:async';

import 'package:ani_life/extentions/string_extention.dart';
import 'package:ani_life/features/pets/data/repositories_impl/edit_pet_details_repository_impl.dart';
import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:ani_life/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final imagePathProvider = StateProvider.autoDispose<String>((ref) => "");

class PetScreen extends ConsumerWidget {
  const PetScreen({super.key, required this.pet});

  final PetModel pet;

  Future<String?> _selectImage(BuildContext context) async {
    final Completer<String?> completer = Completer<String?>();

    await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: const Column(
                        children: [
                          Icon(Icons.camera_alt_outlined),
                          Text("Сделать снимок"),
                        ],
                      ),
                      onTap: () async {
                        final imagePath = await _pickImage(ImageSource.camera);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                        completer.complete(imagePath);
                      },
                    ),
                    GestureDetector(
                      child: const Column(
                        children: [
                          Icon(Icons.filter),
                          Text("Выбрать в галерее"),
                        ],
                      ),
                      onTap: () async {
                        final imagePath = await _pickImage(ImageSource.gallery);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                        completer.complete(imagePath);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    return completer.future;
  }

  Future<String?> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return null;
    }

    final file = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (file == null) {
      return null;
    }
    logger.log(Level.FINE, "вот ваш путь к файлу: ${file.path}");
    return file.path;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = PageController(viewportFraction: 0.8, keepPage: true);
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
              (pet.images.isNotEmpty && pet.images[0].isNotEmpty)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          ListView.builder(
                            physics: const PageScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: pet.images.length,
                            controller: controller,
                            itemBuilder: (context, index) {
                              return Image.network(pet.images[index]);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SmoothPageIndicator(
                                controller: controller,
                                count: pet.images.length,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: Colors.grey.shade300,
                                  dotColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_a_photo_outlined),
        onPressed: () async {
          final image = await _selectImage(context);
          if (image != null) {
            await EditPetDetailsRepositoryImpl().addNewImage(pet.id, image);
          }
        },
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
