import 'package:flutter/material.dart';

class Alerts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('TextField in Dialog'),
      content: TextField(
        onChanged: (value) { },
        decoration: InputDecoration(hintText: "Text Field in Dialog"),
      ),
    );
  }
}
