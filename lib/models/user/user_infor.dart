import 'package:hk_clothes/models/user/contact.dart';

class UserInfor {
  String uid;
  String firstName;
  String lastName;
  String nickname;
  String gender;
  String birthday;
  String email;
  String photoUrl;

  UserInfor(
      {this.uid,
      this.firstName,
      this.lastName,
      this.nickname,
      this.gender,
      this.birthday,
      this.email,
      this.photoUrl});

  UserInfor.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    nickname = json['nickname'];
    gender = json['gender'];
    birthday = json['birthday'];
    email = json['email'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['nickname'] = this.nickname;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['photo_url'] = this.photoUrl;

    return data;
  }
}
