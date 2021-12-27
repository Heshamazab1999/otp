import 'package:cloud_firestore/cloud_firestore.dart';

class Model {
  final String? name;
  final String? key;

  Model({this.name, this.key});

  factory Model.fromJson(DocumentSnapshot snapshot) {
    return Model(
        name: snapshot["name"],
        key: snapshot.id
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    return map;
  }
}
