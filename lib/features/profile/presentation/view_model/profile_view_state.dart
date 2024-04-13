import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:ani_life/features/posts/domain/entites/post_model.dart';
import 'package:ani_life/features/profile/domain/entities/user_model.dart';

sealed class ProfileViewState {}

class ProfileViewLoadingState extends ProfileViewState {}

class ProfileViewErrorState extends ProfileViewState {}

class ProfileViewDataState extends ProfileViewState {
  ProfileViewDataState({
    required this.imageUrl,
    required this.userDetails,
    required this.petsList,
    required this.myPosts,
  });

  final String imageUrl;
  final UserModel userDetails;
  final List<PetModel> petsList;
  final List<PostModel> myPosts;
}
