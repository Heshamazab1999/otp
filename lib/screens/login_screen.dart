import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp/components/logo_image.dart';
import 'package:otp/controller/login_controller.dart';
import 'package:otp/screens/home_screen.dart';
import 'package:otp/screens/pin_code_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PhoneNumber number = PhoneNumber(isoCode: 'EG');
    final _controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Logo(),
              SizedBox(
                height: 25,
              ),
              Text(
                "Enter Your Number",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InternationalPhoneNumberInput(
                      inputBorder: InputBorder.none,
                      onInputChanged: (PhoneNumber number) {
                        _controller.text.value = number.toString();
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },

                      countrySelectorScrollControlled: true,
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        showFlags: true,
                        setSelectorButtonAsPrefixIcon: true,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: _controller.editingController,
                      formatInput: false,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width - 100,
                child: TextButton(
                  onPressed: () {
                   // _controller.verifyPhone(_controller.text.value);
                    print("jjjjj${_controller.text.value}");
                    _controller.editingController.clear();
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
              )
            ])),
      ),
    );
  }
}
