import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otp/models/category_model.dart';

class CollectionServices {
  final _store = FirebaseFirestore.instance;

  Future<List<CollectionModel>> getData() async {
    final data = await _store.collection("collection").get();
    return data.docs.map((e) => CollectionModel.fromJson(e)).toList();
  }

  Future<List<CollectionModel>> getDataSubCollection(String id) async {
    final data =
        await _store.collection("collection").doc(id).collection("data").get();
    return data.docs.map((e) => CollectionModel.fromJson(e)).toList();
  }

  Future<List<CollectionModel>> getProductsSubCollection(
      String id, String key) async {
    final data = await _store
        .collection("collection")
        .doc(id)
        .collection("data")
        .doc(key)
        .collection("product")
        .get();
    return data.docs.map((e) => CollectionModel.fromJson(e)).toList();
  }
}
