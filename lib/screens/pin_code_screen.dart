import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/components/logo_image.dart';
import 'package:otp/controller/login_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final _controller = Get.put(LoginController());

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logo(),
              SizedBox(
                height: 25,
              ),
              Text(
                "Code OTP",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  appContext: context,
                  controller: controller,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      activeColor: Colors.white,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.white,
                      selectedColor: Colors.white,
                      disabledColor: Colors.white,
                      selectedFillColor: Colors.white),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  //   errorAnimationController: errorController,
                  //controller: textEditingController,
                  onCompleted: (v) {
                    _controller.label.value = v;
                  },
                  onChanged: (value) {
                    _controller.label.value = value;
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width - 100,
                child: TextButton(
                  onPressed: () {
                    print(_controller.label.toString());
                     _controller.otpVerify(_controller.label.value);
                  },
                  child: Text(
                    "Verify",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
