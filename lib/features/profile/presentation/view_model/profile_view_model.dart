import 'package:ani_life/features/pets/domain/entites/pet_model.dart';
import 'package:ani_life/features/pets/domain/repositories/pets_list_repository.dart';
import 'package:ani_life/features/pets/internal/pets_list_provider.dart';
import 'package:ani_life/features/profile/domain/entities/user_model.dart';
import 'package:ani_life/features/profile/domain/repositories/user_repository.dart';
import 'package:ani_life/features/profile/internal/user_provider.dart';
import 'package:ani_life/features/profile/presentation/view_model/profile_view_state.dart';
import 'package:ani_life/features/user_images/domain/profile_picture_repository.dart';
import 'package:ani_life/features/user_images/internal/profile_picture_provider.dart';
import 'package:ani_life/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileViewState>(
  (ref) => ProfileViewModel(
    ProfileViewLoadingState(),
    ref.read(profilePictureFetcherProvider),
    ref.read(userProvider),
    ref.read(petsListProvider),
  )..loadData(),
);

class ProfileViewModel extends StateNotifier<ProfileViewState> {
  final ProfilePictureRepository _imageRepository;
  final UserRepository _repositoryUser;
  final PetsListRepository _petsListRepository;

  ProfileViewModel(super.state, this._imageRepository, this._repositoryUser,
      this._petsListRepository);

  Future<void> loadData() async {
    try {
      final String imageUrl = await _imageRepository.fetchProfilePictureUrl();
      final UserModel userDetails = await _repositoryUser.getUser();
      final List<PetModel> petsList = await _petsListRepository.getPetsList();
      state = ProfileViewDataState(
        imageUrl: imageUrl,
        userDetails: userDetails,
        petsList: petsList,
      );
    } catch (e) {
      logger.log(Level.WARNING, e);
      logger.log(Level.WARNING, 'WTF');
      state = ProfileViewErrorState();
    }
  }
}
