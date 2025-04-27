import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  Color colorSeed = Colors.black;
  FontWeight fontWeight = FontWeight.normal;
  String fontFamily = "Quicksand";

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  void setFontFamily(String font) {
    fontFamily = font;
    notifyListeners();
  }

  void setColorSeed(Color value) {
    colorSeed = value;
    notifyListeners();
  }
}
