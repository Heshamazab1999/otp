import 'package:flutter/material.dart';

    class TryNewAppBar extends StatelessWidget {
  @override
      Widget build(BuildContext context) {
    return Scaffold(
      body : Container (
        height : 400,
        width : double.infinity,
        decoration: BoxDecoration(
          color : Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          )

        ),
      )
    );
  }
    }