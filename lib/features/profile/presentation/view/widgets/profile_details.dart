import 'package:ani_life/features/profile/domain/entities/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileDetails extends ConsumerWidget {
  const ProfileDetails(this.user, {super.key});

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  }
}
