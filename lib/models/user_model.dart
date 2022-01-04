import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? password;
  String? key;

  UserModel({this.password, this.username, this.key});

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
        password: snapshot['password'],
        username: snapshot['username'],

        key: snapshot.id);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    return map;
  }
}
