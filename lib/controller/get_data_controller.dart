import 'package:get/get.dart';
import 'package:otp/models/get_data_model.dart';
import 'package:otp/services/get_data.dart';

class GetDataController extends GetxController {
  final _product = <GetDataModel>[].obs;
  final _products = <GetDataModel>[].obs;
  GetDataServices _getDataServices = GetDataServices();

  List<GetDataModel> get product => _product;

  List<GetDataModel> get products => _products;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    _products.assignAll(await _getDataServices.getdata());
  }

  get(String? id, int index) async {
    _product.assignAll(await _getDataServices.get(id));
    print(product[index].name);
  }
}
