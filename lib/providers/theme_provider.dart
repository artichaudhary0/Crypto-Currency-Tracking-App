import 'package:flutter/material.dart';
import '../models/local_storage.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode? themeMode;

  ThemeProvider(String theme) {
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      ThemeMode.dark;
    }
  }
  void toggle() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;

      await LocalStorage.saveTheme("dark");
    } else {
      themeMode = ThemeMode.light;
      await LocalStorage.saveTheme("light");
    }
    notifyListeners();
  }
}
