import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final currentUser = FirebaseAuth.instance.currentUser;

Future<bool> createPost(String postText) async {
  var userDoc = await _firestore.collection("users").doc(currentUser!.email).get();
  Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
  Map<String, dynamic> postData = {
    "authorEmail": currentUser!.email,
    "authorNick": userData["username"],
    "text": postText,
    "authorImage": userData["profileImage"],
    "createDate": DateFormat.yMd().add_Hm().format(DateTime.now()),
  };
  try {
    await _firestore.collection("posts").add(postData);
    return true;
  } catch (e) {
    print(e);
  }
  return false;
}
