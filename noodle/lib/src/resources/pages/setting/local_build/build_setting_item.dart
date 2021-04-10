import 'package:flutter/material.dart';

Widget buildSettingItem(
    {required BuildContext context,
    required void Function() onTapEvent,
    required List<Widget> leftChildren,
    required List<Widget> rightChildren}) {
  return InkWell(
    onTap: onTapEvent,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [...leftChildren, Spacer(), ...rightChildren],
      ),
    ),
  );
}
