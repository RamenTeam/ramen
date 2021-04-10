import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noodle/src/resources/theme/theme.dart';

Widget buildSettingSeparator({required BuildContext context}) {
  return SizedBox(
    height: 1,
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.of(context).currentThemeKey == AppThemeKeys.dark
                ? Colors.grey[800]?.withOpacity(0.4)
                : Colors.grey[300]),
      ),
    ),
  );
}
