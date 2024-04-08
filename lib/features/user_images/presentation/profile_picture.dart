import 'package:ani_life/features/user_images/internal/profile_picture_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePicture extends ConsumerWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePictureFetcher = ref.watch(profilePictureFetcherProvider);
    final profilePictureUrlFuture = profilePictureFetcher.fetchProfilePictureUrl();

    return FutureBuilder(
      future: profilePictureUrlFuture,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if ((snapshot.hasError) || (snapshot.data == "")) {
            return Image.asset("assets/images/no-image-image.png");
          } else {
            return Image.network(snapshot.data!);
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}