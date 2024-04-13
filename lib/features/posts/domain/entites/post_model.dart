class PostModel {
  final String authorEmail;
  final String authorImage;
  final String authorNick;
  final String createdAt;
  final String postText;
  final String postImage;

  PostModel({
    required this.authorEmail,
    required this.authorImage,
    required this.authorNick,
    required this.createdAt,
    required this.postText,
    required this.postImage,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      authorEmail: map['authorEmail'],
      authorImage: map['authorImage'],
      authorNick: map['authorNick'],
      createdAt: map['createDate'],
      postText: map['text'],
      postImage: map['postImage'] ??
          "", // Use null-aware operator to handle missing postImage
    );
  }
}
