import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otp/models/get_data_model.dart';
import 'package:otp/screens/ads.dart';
import 'package:otp/screens/home_screen.dart';
import 'package:otp/screens/pin_code_screen.dart';
import 'package:otp/services/google_services.dart';

class LoginController extends GetxController {
  FirebaseService firebaseService = FirebaseService();
  TextEditingController textEditingController = TextEditingController();
  final _picker = ImagePicker();
  final _select = false.obs;
  final _labels = ''.obs;
  final _image = ''.obs;
  final email = ''.obs;
  final password = ''.obs;

  // final box = GetStorage();
  final code = 0.obs;
  RxInt i = 0.obs;

  convert(int index) {
    i.value = index;
  }

  bool get select => _select.value;

  String get labels => _labels.value;

  String get images => _image.value;

  change() {
    _select.value = true;
  }

  changes() {
    _select.value = false;
  }

  Future login() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    Get.to((() => HomeScreen()));
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  var isLoading = false.obs;
  var verId = '';
  var authStatus = ''.obs;
  var auth = FirebaseAuth.instance;
  final label = ''.obs;
  final text = ''.obs;
  final TextEditingController editingController = TextEditingController();

  verifyPhone(String phone) async {
    isLoading.value = true;
    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 50),
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential) {
          if (auth.currentUser != null) {
            isLoading.value = false;
            authStatus.value = "login successfully";
          }
        },
        verificationFailed: (authException) {
          Get.snackbar("sms code info", "otp code hasn't been sent!!");
        },
        codeSent: (String id, int? forceResent) {
          isLoading.value = false;
          this.verId = id;
          authStatus.value = "login successfully";
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verId = id;
        });
    Get.to(() => PinCodeScreen());
  }

  /////////
  otpVerify(String otp) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verId, smsCode: otp));
      if (userCredential.user != null) {
        isLoading.value = false;
        print("Hello");
        Get.to(() => HomeScreen());
      }
    } on Exception catch (e) {
      Get.snackbar("otp info", "otp code is not correct !!");
    }
  }

  Future loginWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      Get.to((() => HomeScreen()));
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      print(e.toString());
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: TextField(
        onChanged: (value) {
          _labels.value = value;
        },
        onSubmitted: (value) {
          _labels.value = value;
        },
        controller: textEditingController,
        decoration: InputDecoration(hintText: "Text Field in Dialog"),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  selectImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) _image.value = image.path;
    } catch (e) {
      print(e.toString());
    }
  }

  create() {
    firebaseService.login(email.value, password.value);
  }

  Future<void> reset() async {
    await firebaseService.reset();
  }

  BannerAd? _bottomBannerAd;
  bool isLoaded = false;
  late AdsManager adManager;

  Future<void> getBottomBannerAd(AdsManager adManager) async {
    final adInitialize = MobileAds.instance.initialize();
    AdsManager(initialization: adInitialize);
    _bottomBannerAd = BannerAd(
      adUnitId: adManager.bannerAdUnitId,
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isLoaded = true;
          print('Ad loaded to load: $isLoaded !!!!!!');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          //ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    )..load();
  }

  Widget showAd() {
    return isLoaded
        ? Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffffda11),
              ),
              //color: Color(0xffffda11),
            ),
            alignment: Alignment.center,
            height: _bottomBannerAd!.size.height.toDouble(),
            width: _bottomBannerAd!.size.width.toDouble(),
            child: AdWidget(ad: _bottomBannerAd!),
          )
        : Container(
            color: Colors.black87,
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
          );
  }

  final list = <String>["A", "B", "C", "v", "v", "vvvvvv"];
  final List l = [].obs;

  // write() {
  //   box.write('quote', list);
  //   print(box.read('quote'));
  //   // l.assignAll(box.read('quote'));
  // }

  final List empty = [].obs;

  // store(int index) {
  //   empty.add(l[index]);
  //   box.write('empty', empty);
  //   print(box.read('empty'));
  //   //empty.assignAll(box.read('empty'));
  // }

  erase(int index) async {
    final box = await Hive.openBox("name");
    //init hive
    box.deleteAt(index);
    print(index);
  }

  Future<void> set() async {
    final box = await Hive.openBox("name"); //init hive
    box.put("key", list);
    List<String> items = box.get("key");
    print(box.get('key'));
    empty.addAll(items);
    // Dave - 30
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit b
    super.onInit();
  }

  List shuffle() {
    var random = new Random();

    // Go through all elements.
    for (var i = l.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = l[i];
      l[i] = l[n];
      l[n] = temp;
    }
    print(l);
    return l;
  }

  increment() {
    code.value += code.value;
  }

  decrement() {
    code.value--;
  }
}
