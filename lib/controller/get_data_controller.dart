import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:otp/db/db_services.dart';
import 'package:otp/locator.dart';
import 'package:otp/models/get_data_model.dart';
import 'package:otp/models/hive_model.dart';
import 'package:otp/services/get_data.dart';
import 'dart:async';

class GetDataController extends GetxController {
  static GetDataController to = Get.find();
  final _product = <GetDataModel>[].obs;
  final _products = <GetDataModel>[].obs;
  final models = <Product>[].obs;
  final hiveServices = locator<HiveServices>();
  final connectivity = Connectivity();
  late StreamSubscription subscription;
  GetDataServices _getDataServices = GetDataServices();

  List<GetDataModel> get product => _product;

  List<GetDataModel> get products => _products;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    connect();
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    subscription.cancel();
  }

  get(
    String? id,
  ) async {
    _product.assignAll(await _getDataServices.get(id));
  }

  Future<StreamSubscription> connect() async {
    subscription = connectivity.onConnectivityChanged.listen((result) async {
      switch (result) {
        case ConnectivityResult.mobile:
          _products.assignAll(await _getDataServices.getdata());
          print(result.toString());
          break;
        case ConnectivityResult.wifi:
          _products.assignAll(await _getDataServices.getdata());
          print(result.toString());
          break;
        case ConnectivityResult.none:
          print(result.toString());

          break;
      }
    });

    return subscription;
  }

  gets() async {
    models.assignAll(await hiveServices.getAllProduct());
    print(models.length);
  }
}
