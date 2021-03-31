import 'package:flutter/material.dart';
import 'package:noodle/src/resources/theme/dark_theme.dart';
import 'package:noodle/src/resources/theme/light_theme.dart';
import 'package:provider/provider.dart';

enum AppThemeKeys { light, dark }

final Map<AppThemeKeys, ThemeData> _themes = {
  AppThemeKeys.dark: darkTheme,
  AppThemeKeys.light: lightTheme,
};

class AppTheme extends ChangeNotifier {
  static AppTheme of(BuildContext context, {bool listen = false}) =>
      Provider.of<AppTheme>(context, listen: listen);

  AppThemeKeys _themeKey = AppThemeKeys.dark;

  ThemeData get currentTheme => _themes[_themeKey];
  AppThemeKeys get currentThemeKey => _themeKey;

  ThemeData getTheme(AppThemeKeys key) {
    return _themes[key];
  }

  void setTheme(AppThemeKeys themeKey) {
    _themeKey = themeKey;
    notifyListeners();
  }

  void switchTheme() {
    if (_themeKey == AppThemeKeys.dark) {
      _themeKey = AppThemeKeys.light;
    } else {
      _themeKey = AppThemeKeys.dark;
    }
    notifyListeners();
  }
}