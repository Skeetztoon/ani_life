import 'package:ani_life/features/posts/domain/entites/post_model.dart';

abstract class MyPostsListRepository {
  Future<List<PostModel>> getMyPosts();
}
