import 'package:flutter/material.dart';
import 'package:noodle/src/resources/shared/submit_button.dart';

class SocialSubmitButton extends StatelessWidget {
  final String text;
  final Color color;
  final Widget icon;
  final void Function() onPressCallback;

  SocialSubmitButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.icon,
      required this.onPressCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
        content: Container(
          margin: EdgeInsets.symmetric(vertical: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              this.icon,
              SizedBox(width: 15),
              Text("${this.text}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline1?.color))
            ],
          ),
        ),
        color: this.color,
        onPressCallback: this.onPressCallback);
  }
}
