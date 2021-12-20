import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class Product extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? key;

  Product({this.name, this.key});

  Product.fromSnapShot(DocumentSnapshot snapshot) {
    name = snapshot["name"];
    key = snapshot.id;
  }
}
