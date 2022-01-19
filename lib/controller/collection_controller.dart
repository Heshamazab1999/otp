import 'package:get/get.dart';
import 'package:otp/models/category_model.dart';
import 'package:otp/services/collection_services.dart';

class CollectionController extends GetxController {
  final services = CollectionServices();
  final collectionModel = <CollectionModel>[].obs;
  final subCollectionModel = <CollectionModel>[].obs;
  final productSubCollectionModel = <CollectionModel>[].obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    collectionModel.assignAll(await services.getData());
  }

  getDataSubCollection(String id) async {
    subCollectionModel.assignAll(await services.getDataSubCollection(id));
  }

  getProductSubCollection(String id, String key) async {
    productSubCollectionModel
        .assignAll(await services.getProductsSubCollection(id, key));
  }
}
