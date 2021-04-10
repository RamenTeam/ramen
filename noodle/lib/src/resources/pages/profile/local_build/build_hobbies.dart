import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

Widget buildHobbies() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: ListTile(
          title: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Hobbies",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              )),
          subtitle: TextFieldTags(
              tagsStyler: TagsStyler(
                tagTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                tagDecoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                tagCancelIcon:
                    Icon(Icons.cancel, size: 16.0, color: Colors.white),
                tagPadding: const EdgeInsets.all(10.0),
              ),
              textFieldStyler: TextFieldStyler(),
              onTag: (tag) {},
              onDelete: (tag) {})),
    ),
  );
}
