import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp/controller/category_controller.dart';
import 'package:otp/models/product_model.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<CategoryModel>>(
          stream: CategoryController.to.getProduct(id!),
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
                          CategoryController.to.getProduct(list[index].key);
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
            return Center(child: CupertinoActivityIndicator());
          }),
    );
  }
}
