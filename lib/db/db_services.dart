import 'dart:io';

import 'package:hive/hive.dart';
import 'package:otp/models/hive_adapter.dart';
import 'package:otp/models/hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveServices {
  static const String nameBox = "Cart";
  late Box<Product> cartBox;

  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(ProductAdapter());
    cartBox = await Hive.openBox<Product>(nameBox);
  }

  addProduct(Product product) async {
    await cartBox.put(product.key, product);
     cartBox.get(product.key);
    print(cartBox.values);
  }

  Future<List<Product>> getAllProduct() async {
    List<Product> logList = [];
    logList.addAll(cartBox.values);
    print(logList.toList());
    return logList;
  }
}
