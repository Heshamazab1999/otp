import 'dart:io';

import 'package:hive/hive.dart';
import 'package:otp/models/hive_adapter.dart';
import 'package:otp/models/hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveServices {
  List<Product> logList = [];

  static const String nameBox = "Cart";
  late Box<Product> cartBox;

  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(ProductAdapter());
    cartBox = await Hive.openBox<Product>(nameBox);
  }

  addProduct(Product product) {
    cartBox.put(product.key, product);
    print(product.key);
    print(product.name);
    // print(cartBox.toMap());
  }

  Future<List<Product>> getAllProduct() async {
    List<Product> logList = [];
    logList.addAll(cartBox.values);
    print(logList);
    return logList;
  }
}
