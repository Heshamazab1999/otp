import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/get_data_controller.dart';
import 'package:otp/models/hive_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Obx(()=> ListView.builder(
          itemCount: GetDataController.to.models.length,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (ctx, index) =>
              Text(GetDataController.to.models[index].name!))),
    );
  }
}
