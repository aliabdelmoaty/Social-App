class CommentModel {
  String? name;
  String? comment;
  String? commentImage;
  String? uId;
  String? profile;
  String? postId;

  CommentModel({
    this.name,
    this.comment,
    this.uId,
    this.profile,
    this.postId,
    this.commentImage,
  });

  CommentModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    comment = json['comment'];
    commentImage = json['commentImage'];
    uId = json['uId'];
    profile = json['profile'];
    postId = json['postId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'comment': comment,
      'commentImage': commentImage,
      'uId': uId,
      'profile': profile,
      'postId': postId,
    };
  }
}
