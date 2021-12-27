import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:otp/components/text.dart';
import 'package:otp/controller/get_data_controller.dart';
import 'package:otp/db/db_services.dart';
import 'package:otp/models/hive_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ValueListenableBuilder<Box<Product>>(
          valueListenable: Hive.box<Product>(HiveServices.nameBox).listenable(),
          builder: (context, value, child) {
            return value.values.isEmpty
                ? CircularProgressIndicator(
              color: Colors.red,
            )
                : ListView.builder(
                itemCount: value.length,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 50,
                      color: Colors.blue,
                      child: Row(
                        children: [
                          TextExample(
                            key: key,
                            product: value.getAt(index),
                          ),
                          // Text(value.getAt(index)!.name.toString()),
                          IconButton(
                              onPressed: () {
                                value.deleteAt(index);
                              },
                              icon: Icon(Icons.clear))
                        ],
                      )),
                ));
          },
        ));
  }
}