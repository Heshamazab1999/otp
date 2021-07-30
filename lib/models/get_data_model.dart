import 'package:cloud_firestore/cloud_firestore.dart';

class GetDataModel {
  String? name;
  String? key;

  GetDataModel({this.name, this.key});

  GetDataModel.fromJson(DocumentSnapshot snapshot) {
    final json = snapshot;
    name = json["name"];
    key = snapshot.id;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }
}
