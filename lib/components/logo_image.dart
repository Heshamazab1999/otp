import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xff63FFFA), width: 2)),
        child: Image.asset(
          "assets/images/mobile_login.png",
          fit: BoxFit.cover,
        ));
  }
}
