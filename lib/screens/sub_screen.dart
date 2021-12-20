import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/get_data_controller.dart';
import 'package:otp/models/get_data_model.dart';
import 'package:otp/screens/products.dart';

class SubScreen extends StatelessWidget {
  const SubScreen({Key? key, this.getDataModel}) : super(key: key);
  final GetDataModel? getDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
            onTap: () {
              Get.to(() => ProductsScreen());
              print(getDataModel!.key);
              GetDataController.to.get(getDataModel!.key);
            },
            child: Text("${getDataModel!.name}")),
      ),
    );
  }
}
