import 'package:ani_life/features/profile/domain/entities/user_model.dart';
import 'package:ani_life/features/profile/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> getUser(String email) async {
    final docSnapshot = await _firestore.collection("users").doc(email).get();
    final data = docSnapshot.data() as Map<String, dynamic>;
    return UserModel(
      username: data["username"] ?? "",
      bio: data["bio"] ?? "",
    );
  }
}
