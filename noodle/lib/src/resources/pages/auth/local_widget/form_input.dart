import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final void Function(String)? onChangedCallback;
  final String labelText;
  final String? errorText;
  final String inputKey;
  bool isObscured = false;

  FormInput(
      {required this.onChangedCallback,
      required this.labelText,
      required this.errorText,
      required this.inputKey,
      isObscured}) {
    this.isObscured = isObscured;
  }

  @override
  Widget build(BuildContext context) {
    return this.isObscured == true
        ? TextField(
            key: Key(this.inputKey),
            onChanged: onChangedCallback,
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1?.color,
            ),
            obscureText: true,
            decoration: InputDecoration(
              labelText: this.labelText,
              helperText: '',
              errorText: this.errorText,
              focusColor: Theme.of(context).textTheme.headline1?.color,
              labelStyle: TextStyle(color: Theme.of(context).highlightColor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).highlightColor, width: 0.6),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          )
        : TextField(
            key: Key(this.inputKey),
            onChanged: onChangedCallback,
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1?.color,
            ),
            decoration: InputDecoration(
              labelText: this.labelText,
              helperText: '',
              errorText: this.errorText,
              focusColor: Theme.of(context).textTheme.headline1?.color,
              labelStyle: TextStyle(color: Theme.of(context).highlightColor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).highlightColor, width: 0.6),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ));
  }
}
