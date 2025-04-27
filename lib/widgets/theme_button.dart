import 'package:flutter/material.dart';
import 'package:storypad_layout_builder/views/theme/theme_view.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          isScrollControlled: false,
          builder: (context) {
            return ThemeView();
          },
        );
      },
      icon: Icon(Icons.color_lens),
    );
  }
}
