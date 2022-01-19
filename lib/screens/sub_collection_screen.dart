import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/collection_controller.dart';
import 'package:otp/screens/product_sub_collection.dart';

class SubCollectionScreen extends StatelessWidget {
  final String? id;

  const SubCollectionScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CollectionController());
    return Scaffold(
      body: Obx(() => GridView.builder(
          itemCount: _controller.subCollectionModel.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  print(_controller.subCollectionModel[index].key);
                  _controller.getProductSubCollection(
                      id!, _controller.subCollectionModel[index].key!);
                  Get.to(() => ProductSubCollectionScreen());
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          child: Image.network(
                            _controller.subCollectionModel[index].image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        _controller.subCollectionModel[index].name!,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
