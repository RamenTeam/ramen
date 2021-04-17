import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildMeetingUserInfo(BuildContext context, Size screenSize) {
  return Container(
      margin: EdgeInsets.only(top: screenSize.height / 1.2),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text("user name",
                    style: Theme.of(context).textTheme.headline3),
              ),
            ],
          )));
}
