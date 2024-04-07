import 'package:ani_life/features/profile/internal/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileDetails extends ConsumerWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Center(child: Text("User not logged in"));
    }

    return ref.watch(userProvider(currentUser.email!)).when(
          data: (user) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(),
                  Text(
                    user.bio.isNotEmpty ? user.bio : "😎",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              const Center(child: Text("Error loading profile")),
        );
  }
}
