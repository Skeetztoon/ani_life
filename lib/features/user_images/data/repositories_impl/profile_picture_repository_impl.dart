import 'package:ani_life/features/user_images/domain/profile_picture_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logging/logging.dart';

class ProfilePictureRepositoryImpl implements ProfilePictureRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger logger = Logger('FirebaseProfilePictureFetcher');

  @override
  Future<String> fetchProfilePictureUrl() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(currentUser!.email).get();
    String fileName = userDoc['profileImage'];

    try {
      final ref = FirebaseStorage.instance.ref().child('usersImages/$fileName');
      final url = await ref.getDownloadURL();
      logger.log(Level.FINE, "your url is: $url");
      return url;
    } catch (e) {
      logger.log(Level.SEVERE, e);
    }

    return "";
  }
}
