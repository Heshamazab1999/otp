import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/get_data_controller.dart';
import 'package:otp/db/db_services.dart';
import 'package:otp/locator.dart';
import 'package:otp/models/hive_model.dart';
import 'package:otp/screens/cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Obx(
            () => GetDataController.to.product.isEmpty
                ? CircularProgressIndicator(
                    color: Colors.red,
                  )
                : Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: GetDataController.to.product.length,
                          itemBuilder: (ctx, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    locator<HiveServices>().addProduct(Product(
                                        key: GetDataController
                                            .to.product[index].key,
                                        name: GetDataController
                                            .to.product[index].name));
                                    // print(GetDataController.to.product[index].key);
                                  },
                                  child: Container(
                                      width: 200,
                                      height: 50,
                                      color: Colors.teal,
                                      child: Center(
                                        child: Text(
                                          GetDataController
                                              .to.product[index].name!,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                ),
                              )),
                      TextButton(
                          onPressed: () {
                            GetDataController.to.getAllData();
                            // locator<HiveServices>().getAllProduct();
                            //  Get.to(()=>CartScreen());
                          },
                          child: Text("ontap"))
                    ],
                  ),
          ),
        ));
  }
}
