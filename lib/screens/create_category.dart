import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/create_category_controller.dart';
import 'package:otp/models/category_model.dart';

class CreateCategory extends StatelessWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CreateCategoryController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Add Product",
              content: SizedBox(
                height: 500,
                width: Get.width,
                child: Column(
                  children: [
                    StreamBuilder<List<CreateModel>>(
                        stream: _controller.getCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final list = snapshot.data as List;
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (ctx, index) => GestureDetector(
                                    onTap: () {
                                      _controller.key.value = list[index].key;
                                    print(_controller.key.value );
                                      },
                                    child: Text(list[index].name!)));
                          }
                          return CircularProgressIndicator();
                        }),
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
                          _controller.product.value = value;
                        },
                        decoration: InputDecoration(
                            hintText: "name of category",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
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
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: TextButton(
              onPressed: () {
                _controller.create();
                _controller.controller.clear();
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
