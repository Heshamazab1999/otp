import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otp/models/category_model.dart';
import 'package:otp/models/product_model.dart';

class CategoryServices {
  final _store = FirebaseFirestore.instance;



  Future<List<CategoryModel>> getCategory() async {
    final data = await _store.collection("category").get();
    return data.docs.map((e) => CategoryModel.fromJson(e)).toList();
  }

  Stream<List<CategoryModel>> getStreamData() {
    return _store
        .collection("category")
        .snapshots()
        .transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
      sink.add(data.docs.map((e) => CategoryModel.fromJson(e)).toList());
    }));
  }

  Future<CategoryModel> addNewCategory(
      CategoryModel categoryModel, String image, String code) async {
    if (image != null && image.isNotEmpty) {
      categoryModel.image = await uploadImage(image, code);
    }
    final ref = await _store.collection("category").add(categoryModel.toJson());
    categoryModel.key = ref.id;
    return categoryModel;
  }

  Future<String> uploadImage(String imagePath, String code) async {
    final ref =
        FirebaseStorage.instance.ref('/notes.txt').child("users_images/$code");
    final uploadTask = ref.putFile(File(imagePath));
    final imageUrl = (await (await uploadTask).ref.getDownloadURL()).toString();
    return imageUrl;
  }
}
