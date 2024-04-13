import 'package:ani_life/features/posts/data/repositories_impl/new_post_repository_impl.dart';
import 'package:ani_life/features/posts/domain/repositories/new_post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newPostProvider =
    Provider<NewPostRepository>((ref) => NewPostRepositoryImpl());
