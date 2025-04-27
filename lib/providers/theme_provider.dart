import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:web/web.dart' as web;

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  Color colorSeed = Colors.black;
  FontWeight fontWeight = FontWeight.normal;
  String fontFamily = "Quicksand";

  ThemeProvider() {
    final themeModeRaw = web.window.localStorage.getItem('themeMode');
    final fontFamilyRaw = web.window.localStorage.getItem('fontFamily');
    final colorSeedRaw = web.window.localStorage.getItem('colorSeed');

    for (var e in ThemeMode.values) {
      if (e.name == themeModeRaw) themeMode = e;
    }

    fontFamily = fontFamilyRaw ?? fontFamily;
    colorSeed = colorSeedRaw != null && int.tryParse(colorSeedRaw) != null
        ? Color(int.parse(colorSeedRaw))
        : colorSeed;
  }

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();

    web.window.localStorage.setItem('themeMode', mode.name);
  }

  void setFontFamily(String font) {
    fontFamily = font;
    notifyListeners();

    web.window.localStorage.setItem('fontFamily', fontFamily);
  }

  void setColorSeed(Color value) {
    colorSeed = value;
    notifyListeners();

    // ignore: deprecated_member_use
    web.window.localStorage.setItem('colorSeed', value.toARGB32().toString());
  }
}
