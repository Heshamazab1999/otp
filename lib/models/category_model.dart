import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionModel {
  String? name;
  String? image;
  String? key;

  CollectionModel({this.name, this.image, this.key});

  factory CollectionModel.fromJson(DocumentSnapshot snapshot) {
    return CollectionModel(
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
