import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildBanner() {
  return Container(
    child: SvgPicture.asset(
      "assets/images/begin_chat.svg",
      semanticsLabel: 'Find Chat Partner',
      height: 200,
    ),
  );
}
