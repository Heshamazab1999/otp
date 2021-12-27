import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp/components/logo_image.dart';
import 'package:otp/controller/login_controller.dart';
import 'package:otp/screens/ads.dart';
import 'package:otp/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AdsManager adManager;

  @override
  Widget build(BuildContext context) {
    PhoneNumber number = PhoneNumber(isoCode: 'EG');
    final _controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Center(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                 Logo(),

                  // SizedBox(
                  //   height: 100,
                  //   child: ListView.builder(
                  //       physics: ClampingScrollPhysics(),
                  //       shrinkWrap: true,
                  //       itemCount: _controller.empty.length,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (ctx, index) => Obx(() => Text(
                  //           _controller.empty.isEmpty
                  //               ? "hh"
                  //               : _controller.empty[index]))),
                  // ),

                  TextField(
                    onChanged: (v) {
                      _controller.email.value = v;
                    },
                  ),
                  // TextField(
                  //   onChanged: (v) {
                  //     _controller.password.value = v;
                  //   },
                  // ),

                  // TextField(
                  //   onChanged: (v) {
                  //     _controller.password.value = v;
                  //   },
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 30, horizontal: 30),
                  //   child: Container(
                  //     height: 45,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: Colors.grey)),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 10),
                  //       child: InternationalPhoneNumberInput(
                  //         inputBorder: InputBorder.none,
                  //         onInputChanged: (PhoneNumber number) {
                  //           _controller.text.value = number.toString();
                  //           print(number.phoneNumber);
                  //         },
                  //         onInputValidated: (bool value) {
                  //           print(value);
                  //         },
                  //         countrySelectorScrollControlled: true,
                  //         selectorConfig: SelectorConfig(
                  //           selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  //           showFlags: true,
                  //           setSelectorButtonAsPrefixIcon: true,
                  //         ),
                  //         ignoreBlank: false,
                  //         autoValidateMode: AutovalidateMode.disabled,
                  //         selectorTextStyle: TextStyle(color: Colors.black),
                  //         initialValue: number,
                  //         textFieldController: _controller.editingController,
                  //         formatInput: false,
                  //         keyboardType: TextInputType.numberWithOptions(
                  //             signed: true, decimal: true),
                  //         onSaved: (PhoneNumber number) {
                  //           print('On Saved: $number');
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: _controller.empty.length,
                      itemBuilder: (ctx, index) => Obx(() => Text(
                            _controller.empty.isEmpty
                                ? "List is Empty"
                                : _controller.empty[index].toString(),
                            style: TextStyle(
                                color: _controller.i.value == index
                                    ? Colors.red
                                    : Colors.black),
                          )))),
                  // Text(_controller.code.value == 0
                  //     ? "bbbbbb"
                  //     : _controller.code.value.toString()),
                  // IconButton(
                  //     onPressed: () {
                  //       _controller.increment();
                  //     },
                  //     icon: Icon(Icons.add)),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextButton(
                      onPressed: () async {
                        // Get.bottomSheet(
                        //   Container(
                        //     width: 200,
                        //     height: 250,
                        //   ),
                        //   backgroundColor: Colors.red,
                        // );
                        _controller.increment();
                        // _controller.shuffle();
                        // _controller.getBottomBannerAd(adManager);
                        // try {
                        //   await _auth.sendPasswordResetEmail(
                        //       email: _controller.email.value);
                        //   print(_controller.email.value);
                        // } catch (e) {
                        //   print("kkkk");
                        // }
                        // _controller.write();
                        // _controller.loginWithFacebook();
                        // _controller.verifyPhone(_controller.text.value);
                        // // _controller.verifyPhone(_controller.text.value);
                        // print("jjjjj${_controller.text.value}");
                        // _controller.editingController.clear();
                         Get.to(() => HomeScreen());
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            _controller.selectImage();
                            // _controller.change();
                            // _controller.showAlertDialog(context);
                          },
                          child: Text("data")),
                      GestureDetector(
                          onTap: () {
                            _controller.changes();
                          },
                          child: Text("data")),
                    ],
                  ),
                  // _controller.select
                  //     ? Container(
                  //         color: Colors.amber,
                  //         height: 150,
                  //         width: 150,
                  //         child: Text("Hello"),
                  //       )
                  //     : Container(
                  //         color: Colors.blue,
                  //         height: 150,
                  //         width: 150,
                  //         child: Center(child: Text("Hello")),
                  //       ),
                  // Text(
                  //   _controller.labels,
                  //   style: TextStyle(fontSize: 30, color: Colors.black),
                  // ),
                  _controller.images != ''
                      ? Container(
                          height: 200,
                          width: 150,
                          child: Image.file(
                            File(_controller.images),
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        )
                      : Container(),
                  IconButton(
                      onPressed: () {
                        _controller.erase(2);
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                      )),
                ])),
          )),
    );
  }
}
