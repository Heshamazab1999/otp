import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otp/models/get_data_model.dart';

class GetDataServices {
  final _store = FirebaseFirestore.instance;

  Future<List<GetDataModel>> get(String? id) async {
    final data =
        await _store.collection("data").doc(id).collection("get").get();
    return data.docs.map((e) => (GetDataModel.fromJson(e))).toList();
  }

  Future<List<GetDataModel>> getdata() async {
    final data = await _store.collection("data").get();
    return data.docs.map((e) => (GetDataModel.fromJson(e))).toList();
  }

  Future<GetDataModel> send(GetDataModel getDataModel) async {
    final ref = await _store.collection("data").add(getDataModel.toJson());
    return getDataModel;
  }
}
