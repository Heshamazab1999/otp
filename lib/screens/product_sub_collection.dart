import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/collection_controller.dart';

class ProductSubCollectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CollectionController());
    return Scaffold(
      body: Obx(() => GridView.builder(
          itemCount: _controller.productSubCollectionModel.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  print(_controller.productSubCollectionModel[index].key);
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          child: Image.network(
                            _controller.productSubCollectionModel[index].image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        _controller.productSubCollectionModel[index].name!,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
