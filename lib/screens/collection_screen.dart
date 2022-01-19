import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/controller/collection_controller.dart';
import 'package:otp/screens/sub_collection_screen.dart';
import 'package:string_to_hex/string_to_hex.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CollectionController());
    return Scaffold(
      body: Obx(() => GridView.builder(
          itemCount: _controller.model.length,
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
                            _controller.model[index].coverImg!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        _controller.model[index].name!,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _controller.model[index].color!.length,
                            itemBuilder: (ctx, index) => Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(StringToHex.toColor(
                                          _controller
                                              .model[index].color![index]))),
                                )),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
