class PostModel {
  final String authorEmail;
  final String authorImage;
  final String authorNick;
  final String createdAt;
  final String postText;
  final String postImage;

  PostModel(this.postImage,
      {required this.authorEmail,
      required this.authorImage,
      required this.authorNick,
      required this.createdAt,
      required this.postText});
}
