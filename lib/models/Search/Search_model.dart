class SearchModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? bio;
  String? profile;
  String? cover;
  SearchModel(
      {this.name,
      this.email,
      this.phone,
      this.uId,
      this.bio,
      this.profile,
      this.cover,
      });
  SearchModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    profile = json['profile'];
    cover = json['cover'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'profile': profile,
      'cover': cover,
    };
  }
}
