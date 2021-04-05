import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Widget content;
  final Color color;
  final void Function() onPressCallback;

  SubmitButton(
      {Key? key,
      required this.content,
      required this.color,
      required this.onPressCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressCallback,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )),
        backgroundColor: MaterialStateProperty.all(color),
      ),
      child: content,
    );
  }
}
