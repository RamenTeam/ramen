import 'package:flutter/material.dart';

Widget buildBio({required BuildContext context, required String bio}) {
  return Container(
    child: ListTile(
      title: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            "Bio",
            style: Theme.of(context).textTheme.headline3,
          )),
      subtitle: Text(
        bio,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ),
  );
}
