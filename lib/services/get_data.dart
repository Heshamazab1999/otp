import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otp/models/get_data_model.dart';

class GetDataServices {
  final _store = FirebaseFirestore.instance;

  Future<List<GetDataModel>> get(String? id) async {
    final data =
        await _store.collection("data").doc(id).collection("get").get();
    final doc = data.docs.map((e) => (GetDataModel.fromJson(e))).toList();
    print(doc);
    return doc;
  }

  Future<GetDataModel> send(String? id, GetDataModel getDataModel) async {
    final data = await _store
        .collection("data")
        .doc(id)
        .collection("get")
        .add(getDataModel.toJson());
    return getDataModel;
  }

  Future<List<GetDataModel>> getdata() async {
    final data = await _store.collection("data").get();
    return data.docs.map((e) => (GetDataModel.fromJson(e))).toList();
  }
}
