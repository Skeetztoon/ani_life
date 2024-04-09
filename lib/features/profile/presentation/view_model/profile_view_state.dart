import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:ani_life/features/profile/domain/entities/user_model.dart';

sealed class ProfileViewState {}

class ProfileViewLoadingState extends ProfileViewState {}

class ProfileViewErrorState extends ProfileViewState {}

class ProfileViewDataState extends ProfileViewState {

  ProfileViewDataState({
    required this.userDetails,
    required this.petsList,
});

  final UserModel userDetails;
  final List<PetModel> petsList;
}
