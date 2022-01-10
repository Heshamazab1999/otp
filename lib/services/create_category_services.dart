import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:otp/models/category_model.dart';
import 'package:otp/models/product_model.dart';

class CreateCategoryServices {
  final _store = FirebaseFirestore.instance;

  Future<CreateModel> createCategory(CreateModel createModel) async {
    final data =
        await _store.collection("CategoryType").add(createModel.toJson());
    createModel.key = data.id;
    return createModel;
  }

  Stream<List<CreateModel>> getCategorys() {
    return _store
        .collection("CategoryType")
        .snapshots()
        .transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
      sink.add(data.docs.map((e) => CreateModel.fromJson(e)).toList());
    }));
  }

  Future<CategoryModel> addNewProduct(
      CategoryModel categoryModel, String image, String code, String id) async {
    if (image.isNotEmpty) {
      categoryModel.image = await uploadImage(image, code);
    }
    final ref = await _store
        .collection("CategoryType")
        .doc(id)
        .collection("product")
        .add(categoryModel.toJson());
    categoryModel.key = ref.id;
    return categoryModel;
  }

  Future<String> uploadImage(String imagePath, String code) async {
    final ref =
        FirebaseStorage.instance.ref('/notes.txt').child("images/$code");
    final uploadTask = ref.putFile(File(imagePath));
    final imageUrl = (await (await uploadTask).ref.getDownloadURL()).toString();
    return imageUrl;
  }
}
