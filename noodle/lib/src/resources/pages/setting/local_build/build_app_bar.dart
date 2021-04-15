import 'package:flutter/material.dart';

dynamic buildAppBar(context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Icon(
              Icons.arrow_back_ios_outlined,
              color: Theme.of(context).primaryColor,
            ),
            GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Text(
                "Back",
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
        Spacer(),
        Container(
            child: Text(
              "Setting",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            margin: EdgeInsets.only(right: 50)),
        Spacer(),
        Container()
      ],
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
