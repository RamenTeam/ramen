import 'package:flutter/material.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/submit_button.dart';

class SocialSubmitButton extends StatelessWidget {
  final String media;
  final Color color;
  final Widget icon;
  final void Function() onPressCallback;

  SocialSubmitButton(
      {Key? key,
      required this.color,
      required this.media,
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
              Text("Sign in with ${this.media}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor))
            ],
          ),
        ),
        color: this.color,
        onPressCallback: this.onPressCallback);
  }
}
