class PetModel {
  PetModel({
    required this.id,
    required this.name,
    required this.age,
    required this.isMale,
    required this.images,
    required this.type,
    required this.bio,
  });

  final String id;
  final String name;
  final int age;
  final bool isMale;
  final List<String> images;
  final String type;
  final String bio;
}
