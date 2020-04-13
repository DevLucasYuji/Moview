import 'dart:collection';

class UserModel {
  final String user;
  final String password;

  UserModel({this.user, this.password});

  UserModel.fromJson(HashMap<String, dynamic> json)
      : user = json["user"],
        password = json["password"];
}
