import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildInteractionOptions(BuildContext context) {
  return Positioned(
    right: 10,
    bottom: 150,
    child: Column(
      children: [
        IconButton(
            icon: FaIcon(FontAwesomeIcons.exclamationCircle, color: Colors.red),
            onPressed: () {}),
        IconButton(
            icon: FaIcon(
              FontAwesomeIcons.heart,
              color: Colors.red,
            ),
            onPressed: () {}),
        IconButton(
            icon: FaIcon(
              FontAwesomeIcons.bitcoin,
              color: Colors.red,
            ),
            onPressed: () {}),
      ],
    ),
  );
}
