import 'package:flutter/material.dart';
import 'package:otp/models/hive_model.dart';

class TextExample extends StatelessWidget {
  const TextExample({Key? key, this.product}) : super(key: key);
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Text(
        product!.name == null ? "NAME EQUAL Null" : product!.name.toString());
  }
}
