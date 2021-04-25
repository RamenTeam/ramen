import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final void Function(String)? onChangedCallback;
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final TextInputType textInputType;
  final TextAlignVertical textAlignVertical;
  final int lines;
  final TextEditingController? controller;

  FormInput({
    required this.onChangedCallback,
    required this.labelText,
    required this.errorText,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.textAlignVertical = TextAlignVertical.center,
    this.lines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChangedCallback,
      style: TextStyle(
        color: Theme.of(context).textTheme.headline1?.color,
      ),
      textAlignVertical: textAlignVertical,
      keyboardType: textInputType,
      minLines: lines,
      maxLines: lines,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: this.labelText,
        errorText: this.errorText,
        focusColor: Theme.of(context).textTheme.headline1?.color,
        labelStyle: TextStyle(color: Theme.of(context).highlightColor),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).highlightColor, width: 0.6),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
