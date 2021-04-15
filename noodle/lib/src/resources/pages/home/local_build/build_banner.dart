import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildBanner() {
  return Container(
    margin: EdgeInsets.all(20),
    child: ClipRRect(
      child: Image.asset(
        "assets/images/ramen-banner.png",
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
