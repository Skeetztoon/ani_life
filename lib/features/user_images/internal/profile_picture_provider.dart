import 'package:ani_life/features/user_images/data/repositories_impl/profile_picture_repository_impl.dart';
import 'package:ani_life/features/user_images/domain/profile_picture_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profilePictureFetcherProvider = Provider<ProfilePictureFetcher>((ref) {
  return FirebaseProfilePictureFetcher();
});
