import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otp/models/model.dart';

class DataServices {
  final _store = FirebaseFirestore.instance;

  Future<Model> sendData(Model model) async {
    final data = await _store.collection("collectionPath").add(model.toJson());
    return model;
  }

  Future<List<Model>> getData() async {
    final data = await _store.collection("collectionPath").get();
    return data.docs.map((e) => Model.fromJson(e)).toList();
  }

  Stream<List<Model>> get() {
    return _store
        .collection("collectionPath")
        .snapshots()
        .transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
      sink.add(data.docs.map((e) => Model.fromJson(e)).toList());
    }));
  }
}
