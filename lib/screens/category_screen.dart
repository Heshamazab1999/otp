import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/category_controller.dart';
import 'package:otp/models/product_model.dart';
import 'package:otp/screens/product_category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CategoryController());
    return Scaffold(
      body: StreamBuilder<List<CategoryModel>>(
          stream: _controller.getStream(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              final list = snapshot.data as List;
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.to(() => ProductCategory(
                                id: list[index].key,
                              ));
                        },
                        child: Card(
                          elevation: 1,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Image.network(list[index].image!)),
                              Text(
                                list[index].name,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ));
            }
            return CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Add Category",
              content: Column(
                children: [
                  Obx(() => MaterialButton(
                        onPressed: () {
                          _controller.selectImage();
                        },
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: _controller.image.isNotEmpty
                                ? Image.file(File(_controller.image.value))
                                : Image.asset(
                                    "assets/images/mobile_login.png")),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      onChanged: (value) {
                        _controller.label.value = value;
                      },
                      decoration: InputDecoration(
                          hintText: "name of category",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 100,
                      height: 30,
                      child: TextButton(
                        onPressed: () {
                          _controller.sendData();
                          Get.back();
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.teal),
                      ))
                ],
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
