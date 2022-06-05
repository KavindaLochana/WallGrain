import 'package:flutter/material.dart';
import 'package:WallGrain/darkMode/darkThemePrefs.dart';

class DarkThemeProvider with ChangeNotifier {
  var darkThemePreferences = DarkThemePreferences();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    print('came to theme provider');
    _darkTheme = value;
    darkThemePreferences.setDarkTheme(value);
    notifyListeners();
  }
}
