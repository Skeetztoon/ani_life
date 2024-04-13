import 'package:ani_life/features/posts/domain/entites/post_model.dart';
import 'package:ani_life/features/posts/domain/repositories/my_posts_list_repository.dart';
import 'package:ani_life/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logging/logging.dart';

class MyPostsListRepositoryImpl extends MyPostsListRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Future<List<PostModel>> getMyPosts() async {
    List<String> postsIds = [];
    List<PostModel> userPosts = [];
    try {
      final docRef = _firestore.collection("users").doc(currentUser!.email);
      final docSnapshot = await docRef.get();
      final data = docSnapshot.data() as Map<String, dynamic>;
      postsIds = List<String>.from(data["posts"] ?? []);
    } catch (e) {
      logger.log(Level.SEVERE, "$e, ОШИБКА ПРИ ПАРСИНГЕ ID ПОСТОВ");
    }
    logger.log(Level.FINE, "$postsIds postsIds");

    if (postsIds.isNotEmpty) {
      try {
        for (var postId in postsIds) {
          final postRef = _firestore.collection("posts").doc(postId);
          final postSnapshot = await postRef.get();
          final data = postSnapshot.data() as Map<String, dynamic>;

          String authorImageLink = "";
          if (data["authorImage"] != null &&
              data["authorImage"].toString().isNotEmpty) {
            final authorImageRef = FirebaseStorage.instance
                .ref()
                .child('usersImages/${data["authorImage"]}');
            authorImageLink = await authorImageRef.getDownloadURL();
          }

          String postImageLink = "";
          if (data["postImage"] != null &&
              data["postImage"].toString().isNotEmpty) {
            final postImageRef = FirebaseStorage.instance
                .ref()
                .child('postsImages/${data["postImage"]}');
            postImageLink = await postImageRef.getDownloadURL();
          }
          final post = PostModel(
            authorEmail: data["authorEmail"] ?? "",
            authorImage: authorImageLink,
            authorNick: data["authorNick"] ?? "",
            createdAt: data["createDate"] ?? "",
            postText: data["text"] ?? "",
            postImage: postImageLink,
          );
          logger.log(Level.FINER, "пост добавлен в массив");
          userPosts.add(post);
        }
      } catch (e) {
        logger.log(Level.SEVERE, "$e, ОШИБКА ПРИ ПАРСИНГЕ ПОСТА");
      }
    }
    return userPosts;
  }
}
