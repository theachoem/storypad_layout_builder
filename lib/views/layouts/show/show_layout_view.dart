import 'package:flutter/material.dart';
import 'package:storypad_layout_builder/widgets/story_header.dart';
import 'package:storypad_layout_builder/widgets/theme_button.dart';

class ShowLayoutView extends StatelessWidget {
  const ShowLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [ThemeButton()]),
      body: ListView(children: [StoryHeader()]),
    );
  }
}
