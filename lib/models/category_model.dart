import 'package:cloud_firestore/cloud_firestore.dart';

class CreateModel {
  String? name;
  String? image;
  String? key;

  CreateModel({this.name, this.image, this.key});

  factory CreateModel.fromJson(DocumentSnapshot snapshot) {
    return CreateModel(
      name: snapshot["name"],
      image: snapshot["image"],
      key: snapshot.id,
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    return map;
  }
}
