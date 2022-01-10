import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? image;
  String? name;
  String? key;

  CategoryModel({this.name, this.image, this.key});

  factory CategoryModel.fromJson(DocumentSnapshot snapshot) {
    return CategoryModel(
        name: snapshot['name'], image: snapshot['image'], key: snapshot.id);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
   map['name']=name;
   map['image']=image;
    return map;
  }
}
