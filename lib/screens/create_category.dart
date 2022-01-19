import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/create_category_controller.dart';
import 'package:otp/models/category_model.dart';
import 'package:otp/screens/category_screen.dart';

class CreateCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CreateCategoryController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Add Product",
              content: SizedBox(
                height: Get.height - 500,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder<List<CollectionModel>>(
                          stream: _controller.getCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _controller.category = snapshot.data;
                              return Obx(() => DropdownButton<CollectionModel>(
                                    value: _controller.selected.value
                                        ? _controller.createModel.value
                                        : _controller.category![0],
                                    onChanged: (newValue) {
                                      _controller.selected.value = true;
                                      _controller.createModel.value = newValue!;
                                      _controller.key.value = newValue.key!;
                                      print(_controller.key.value);
                                    },
                                    items: snapshot.data!.map((category) {
                                      return DropdownMenuItem<CollectionModel>(
                                        child: new Text(category.name!),
                                        value: category,
                                      );
                                    }).toList(),
                                  ));
                            }
                            return CupertinoActivityIndicator();
                          }),
                      // StreamBuilder<List<CreateModel>>(
                      //     stream: _controller.getCategories(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasData) {
                      //         final list = snapshot.data as List;
                      //         return ListView.builder(
                      //             shrinkWrap: true,
                      //             physics: ClampingScrollPhysics(),
                      //             itemCount: list.length,
                      //             itemBuilder: (ctx, index) => TextButton(
                      //                 onPressed: () {
                      //                   _controller.key.value = list[index].key;
                      //                   print(_controller.key.value);
                      //                 },
                      //                 child: Text(list[index].name!)));
                      //       }
                      //       return CupertinoActivityIndicator();
                      //     }),
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
                      TextField(
                        onChanged: (value) {
                          _controller.product.value = value;
                        },
                        decoration: InputDecoration(
                            hintText: "name of category",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 30,
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
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.teal),
                          ))
                    ],
                  ),
                ),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => MaterialButton(
                onPressed: () {
                  _controller.selectCategoryImage();
                  _controller.categoryImage.value = '';
                },
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: _controller.categoryImage.isNotEmpty
                        ? Image.file(File(_controller.categoryImage.value))
                        : Image.asset("assets/images/mobile_login.png")),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _controller.controller,
              onChanged: (value) {
                _controller.label.value = value;
                print(_controller.label.value);
              },
              decoration: InputDecoration(
                hintText: "Create Category",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 250,
            child: TextButton(
              onPressed: () {
                _controller.create();
                _controller.controller.clear();
                Get.to(() => CategoryScreen());
              },
              child: Text(
                "Create",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
