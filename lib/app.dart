import 'package:flutter/material.dart';
import 'package:storypad_layout_builder/app_theme.dart';
import 'package:storypad_layout_builder/views/layouts/show/show_layout_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      builder: (context, lightTheme, darkTheme, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: ShowLayoutView(),
        );
      },
    );
  }
}
