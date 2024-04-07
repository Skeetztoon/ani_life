import 'package:ani_life/features/profile/data/repositories_impl/user_repository_impl.dart';
import 'package:ani_life/features/profile/domain/entities/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    FutureProvider.autoDispose.family<UserModel, String>((ref, email) async {
  final userRepositoryImpl = UserRepositoryImpl();
  return await userRepositoryImpl.getUser(email);
});
