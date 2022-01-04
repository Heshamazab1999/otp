import 'package:get/get.dart';
import 'package:otp/models/user_model.dart';
import 'package:otp/screens/home_screen.dart';
import 'package:otp/screens/login_screen.dart';
import 'package:otp/services/auth_services.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  final _isLogged = false.obs;
  var _currentUser = UserModel().obs;
  final _services = new AuthServices();

  bool get isLogged => _isLogged.value;

  UserModel get currentUser => _currentUser.value;

  @override
  Future<void> onInit() async {
    ever(_isLogged, handelAuthChanged);
    var user = await _services.getCurrentUser();
    if (user != null) {
      _currentUser.value = user;
      _isLogged.value = true;
    } else {
      _isLogged.value = false;
    }
  }

  handelAuthChanged(isLoggedIn) async {
    await Future.delayed(Duration(seconds: 1));
    if (isLoggedIn) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  changeLoggedIn(bool isLogged, UserModel user) {
    if (isLogged) {
      _currentUser.value = user;
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  logOut() {
    _services.signOut();
  }
}
