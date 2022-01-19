import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/collection_controller.dart';
import 'package:otp/screens/sub_collection_screen.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CollectionController());
    return Scaffold(
      body: Obx(() => GridView.builder(
          itemCount: _controller.collectionModel.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  print(_controller.collectionModel[index].key);
                  _controller.getDataSubCollection(
                      _controller.collectionModel[index].key!);
                  Get.to(() => SubCollectionScreen(
                        id: _controller.collectionModel[index].key,
                      ));
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          child: Image.network(
                            _controller.collectionModel[index].image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        _controller.collectionModel[index].name!,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
