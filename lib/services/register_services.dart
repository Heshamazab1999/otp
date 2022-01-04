import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp/controller/auth_controller.dart';
import 'package:otp/models/user_model.dart';
import 'package:otp/services/auth_services.dart';

class SignUpServices {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _authServices = new AuthServices();

  Future<UserModel> register(UserModel userModel) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userModel.username!, password: userModel.password!);
    } catch (e) {
      print(e);
    }
    UserModel createdUser = await addNewUser(userModel);
    _authServices.updateStorage(createdUser);
    return createdUser;
  }



  Future<UserModel> addNewUser(UserModel userModel) async {

    final ref = await _fireStore.collection("users").add(userModel.toJson());
    userModel.key = ref.id;
    return userModel;
  }

}
