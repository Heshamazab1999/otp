import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/get_data_controller.dart';
import 'package:otp/models/get_data_model.dart';
import 'package:otp/screens/category_screen.dart';
import 'package:otp/screens/sub_screen.dart';
import 'package:otp/services/get_data.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(GetDataController());
    GetDataServices getDataServices = GetDataServices();
    return Scaffold(
      body: Center(
          child: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controller.products.isEmpty
                  ? CircularProgressIndicator(
                      color: Colors.red,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _controller.products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => SubScreen(
                                  getDataModel: GetDataModel(
                                      name: _controller.products[index].name,
                                      key: _controller.products[index].key),
                                ));
                            // _controller.get(_controller.products[index].key, index);
                            print(_controller.products[index].name);
                            // getDataServices.send(_controller.products[index].key,
                            //     GetDataModel(name: "Ahmed"));
                          },
                          child: Container(
                            height: 50,
                            color: Colors.amber,
                            child: Text(
                              "${_controller.products[index].name}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width - 100,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => CategoryScreen());
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
