import 'package:ani_life/features/posts/domain/entites/post_model.dart';

abstract class PostsListRepository {
  Future<List<PostModel>> getPostsList();
}
