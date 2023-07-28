class PostModel {
  String? name;
  String? postVideo;
  String? postImage;
  String? uId;

  String? profile;
  String? dateTime;
  String? text;

  PostModel({
    this.name,
    this.postVideo,
    this.uId,
    this.profile,
    this.dateTime,
    this.postImage,
    this.text,

  });
  PostModel.fromJson(Map<String, dynamic> json) {
    postVideo = json['postVideo'];
    name = json['name'];
    uId = json['uId'];
    profile = json['profile'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'uId': uId,
      'postImage': postImage,
      'postVideo': postVideo,
      'profile': profile,
      'text': text
    };
  }
}
