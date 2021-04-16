import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noodle/src/resources/theme/theme.dart';

Widget buildBanner(context, bool isFinding) {
  return Container(
    child: Image.asset(
      AppTheme.of(context).currentThemeKey == AppThemeKeys.dark
          ? isFinding
              ? "assets/images/ramen-bowl-dark.png"
              : "assets/images/ramen-jumbotron-dark.png"
          : isFinding
              ? "assets/images/ramen-bowl-light.png"
              : "assets/images/ramen-jumbotron-light.png",
      height: 200,
    ),
  );
}
