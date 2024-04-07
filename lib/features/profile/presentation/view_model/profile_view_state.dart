sealed class ProfileViewState {}

class ProfileViewLoadingState extends ProfileViewState {}

class ProfileViewErrorState extends ProfileViewState {}

class ProfileViewDataState extends ProfileViewState {
  // final List<Pet>
}
