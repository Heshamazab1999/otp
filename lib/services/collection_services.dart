import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:otp/models/api_model.dart';
import 'package:otp/models/category_model.dart';

class CollectionServices {
  final _store = FirebaseFirestore.instance;
  final Dio _dio = Dio();

  Future<List<Data>> fetchApi() async {
    Response response = await _dio.get(
        "https://findfamily.net/eshop/api/buyers/products?lang=en&categoryId=1");
    if (response.statusCode == 200) {
      Iterable list = response.data['data'];
      print(response.data);
      return list.map((e) => Data.fromJson(e)).toList();
    }
    throw 'exception';
  }

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
