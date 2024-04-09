import 'package:ani_life/features/profile/domain/entities/user_model.dart';
import 'package:ani_life/features/profile/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Future<UserModel> getUser() async {
    final docSnapshot =
        await _firestore.collection("users").doc(currentUser!.email).get();
    final data = docSnapshot.data() as Map<String, dynamic>;
    return UserModel(
      username: data["username"] ?? "",
      bio: data["bio"] ?? "",
    );
  }
}
