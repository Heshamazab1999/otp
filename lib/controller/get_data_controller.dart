import 'package:get/get.dart';
import 'package:otp/db/db_services.dart';
import 'package:otp/models/get_data_model.dart';
import 'package:otp/models/hive_model.dart';
import 'package:otp/services/get_data.dart';

class GetDataController extends GetxController {
  static GetDataController to = Get.find();
  final _product = <GetDataModel>[].obs;
  final _products = <GetDataModel>[].obs;
  final models = <Product>[].obs;
  HiveServices hiveServices = HiveServices();
  GetDataServices _getDataServices = GetDataServices();

  List<GetDataModel> get product => _product;

  List<GetDataModel> get products => _products;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    _products.assignAll(await _getDataServices.getdata());
  }

  get(
    String? id,
  ) async {
    _product.assignAll(await _getDataServices.get(id));
  }

  getAllData() {
    models.addAll(hiveServices.logList);
    print(models.length);
  }
}
