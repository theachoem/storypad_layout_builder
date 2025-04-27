import 'package:flutter/material.dart';
import 'package:storypad_layout_builder/app_theme.dart';

class StoryHeader extends StatelessWidget {
  const StoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(context),
          SizedBox(height: 12.0),
          buildLabels(context),
        ],
      ),
    );
  }

  Widget buildLabels(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: (AppTheme.isDarkMode(context) ? Colors.white : Colors.black)
                .withValues(alpha: 0.06),
          ),
          child: Text(
            "📌 3213 days ago",
            style: TextTheme.of(context).labelMedium,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: (AppTheme.isDarkMode(context) ? Colors.white : Colors.black)
                .withValues(alpha: 0.06),
          ),
          child: Text("2:59pm", style: TextTheme.of(context).labelMedium),
        ),
      ],
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: [
        Text(
          "20",
          style: TextTheme.of(
            context,
          ).headlineLarge?.copyWith(color: ColorScheme.of(context).primary),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("th", style: TextTheme.of(context).labelSmall),
              Text("March 2025", style: TextTheme.of(context).labelMedium),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorScheme.of(context).onSurface.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.emoji_emotions),
        ),
      ],
    );
  }
}
