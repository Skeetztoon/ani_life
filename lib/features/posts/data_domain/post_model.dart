class Post {
  final String authorEmail;
  final String authorNick;
  final String authorImage;
  final String createDate;
  final String postText;
  final String postImage;

  Post(this.postImage,
      {required this.authorEmail,
      required this.authorNick,
      required this.authorImage,
      required this.createDate,
      required this.postText});
}
