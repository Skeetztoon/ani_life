import 'package:ani_life/features/profile/data/repositories_impl/user_repository_impl.dart';
import 'package:ani_life/features/profile/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = Provider<UserRepository>((ref) => UserRepositoryImpl());