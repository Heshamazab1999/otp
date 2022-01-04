import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:otp/models/user_model.dart';
import 'package:otp/services/auth_services.dart';

class LoginServices {
  final _authServices = new AuthServices();
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;


  Future<UserModel> login(
       String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
    UserModel createdUser = await getUserByEmail(password, email);
    _authServices.updateStorage(createdUser);
    return createdUser;
  }

  Future<UserModel> getUserByEmail(
       String password, String email) async {
    final data = await _fireStore
        .collection("users")
        .where("password", isEqualTo: password)
        .where("username", isEqualTo: email)
        .get();
    if (data.docs.length > 0) {
      return UserModel.fromJson(data.docs.first);
    }
    throw
        "Wrong to find your Email !";
  }
}
