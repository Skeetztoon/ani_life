import 'package:ani_life/features/posts/data/repositories_impl/my_posts_list_repository_impl.dart';
import 'package:ani_life/features/posts/domain/repositories/my_posts_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myPostsListProvider =
    Provider<MyPostsListRepository>((ref) => MyPostsListRepositoryImpl());
