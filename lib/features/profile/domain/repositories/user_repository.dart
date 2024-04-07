import 'package:ani_life/features/profile/domain/entities/user_model.dart';

abstract class UserRepository {
  Future<UserModel> getUser(String email);
}
