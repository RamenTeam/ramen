import 'package:flutter/material.dart';

Widget buildDivider({required String text, required BuildContext context}) {
  return Row(children: <Widget>[
    Expanded(
        child: Divider(
      height: 2,
      thickness: 1,
      color: Theme.of(context).highlightColor,
    )),
    SizedBox(width: 20),
    Text(text,
        style: TextStyle(color: Theme.of(context).textTheme.headline2?.color)),
    SizedBox(width: 20),
    Expanded(
        child: Divider(
      height: 2,
      thickness: 1,
      color: Theme.of(context).highlightColor,
    )),
  ]);
}
