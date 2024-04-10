import 'package:ani_life/features/posts/domain/repositories/new_post_repository.dart';
import 'package:ani_life/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class NewPostRepositoryImpl extends NewPostRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Future<void> createNewPost(String postText, String imageUrl) async {
    var userDoc =
    await _firestore.collection("users").doc(currentUser!.email).get();
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    Map<String, dynamic> postData = {
      "authorEmail": currentUser!.email,
      "authorNick": userData["username"],
      "authorImage": userData["profileImage"],
      "createDate": DateFormat.yMd().add_Hm().format(DateTime.now()),
      "text": postText,
      "postImage": imageUrl,// TODO сделать добавление картинок
    };
    try {
      await _firestore.collection("posts").add(postData);
    } catch (e) {
      logger.log(Level.SEVERE, e);
    }
  }
}