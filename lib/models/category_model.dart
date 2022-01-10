import 'package:cloud_firestore/cloud_firestore.dart';

class CreateModel {
  String? name;
  String? key;

  CreateModel({this.name, this.key});

  factory CreateModel.fromJson(DocumentSnapshot snapshot) {
    return CreateModel(
      name: snapshot["name"],
      key: snapshot.id,
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }
}
