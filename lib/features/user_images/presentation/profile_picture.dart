import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePicture extends ConsumerWidget {
  const ProfilePicture(this.imageUrl, {super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (imageUrl.isEmpty)
        ? Image.asset("assets/images/no-image-image.png")
        : Image.network(imageUrl);
  }
}
