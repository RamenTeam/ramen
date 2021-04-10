import 'package:flutter/material.dart';

Widget buildBio(context) {
  return Container(
    child: ListTile(
      title: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            "Bio",
            style: Theme.of(context).textTheme.headline3,
          )),
      subtitle: Text(
        "The overflow property's behavior is affected by the softWrap argument. "
        "If the softWrap is true or null, the glyph causing overflow, and those that follow, "
        "will not be rendered. Otherwise, it will be shown with the given overflow option.",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ),
  );
}
