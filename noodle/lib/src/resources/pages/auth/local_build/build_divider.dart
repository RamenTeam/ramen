import 'package:flutter/material.dart';

Widget buildDivider({String text}) {
  return Row(children: <Widget>[
    Expanded(
        child: Divider(
          height: 2,
          thickness: 1,
          color: Colors.black.withOpacity(0.3),
        )),
    SizedBox(width: 20),
    Text(text),
    SizedBox(width: 20),
    Expanded(
        child: Divider(
          height: 2,
          thickness: 1,
          color: Colors.black.withOpacity(0.3),
        )),
  ]);
}