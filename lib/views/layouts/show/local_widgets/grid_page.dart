import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:storypad_layout_builder/core/services/image_picker_service.dart';
import 'package:storypad_layout_builder/views/layouts/show/local_widgets/rotate_child.dart';
import 'package:storypad_layout_builder/views/layouts/show/local_widgets/sticker_sheet.dart';
import 'package:storypad_layout_builder/views/layouts/show/story_page.dart';

class GridPage extends StatelessWidget {
  const GridPage({
    super.key,
    required this.page,
    required this.onChanged,
  });

  final StoryPage page;
  final void Function(StoryPage newPage) onChanged;

  void showSheet(BuildContext context) async {
    final newPage = await StickerSheet.showSheet(context, page);
    if (newPage != null) {
      onChanged(newPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topLeftSticker = page.topLeftSticker != null
        ? ImagePickerService.getContent(page.topLeftSticker!.imageKey)
        : null;

    final topRightSticker = page.topRightSticker != null
        ? ImagePickerService.getContent(page.topRightSticker!.imageKey)
        : null;

    final bottomLeftSticker = page.bottomLeftSticker != null
        ? ImagePickerService.getContent(page.bottomLeftSticker!.imageKey)
        : null;

    final bottomRightSticker = page.bottomRightSticker != null
        ? ImagePickerService.getContent(page.bottomRightSticker!.imageKey)
        : null;

    Color? backgroundColor;
    if (page.backgroundSeedColor != null) {
      final color = Color(page.backgroundSeedColor!);
      backgroundColor = ColorScheme.fromSeed(
        seedColor: color,
        brightness: ColorScheme.of(context).brightness,
      ).surface;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        DottedBorder(
          color: Theme.of(context).dividerColor,
          strokeWidth: 2,
          dashPattern: [5],
          borderType: BorderType.RRect,
          radius: Radius.zero,
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 0,
              children: [
                TextFormField(
                  onTap: () => showSheet(context),
                  initialValue: page.title,
                  style: TextTheme.of(context).titleMedium,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                TextFormField(
                  onTap: () => showSheet(context),
                  initialValue: page.body,
                  style: TextTheme.of(context).bodyMedium,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    border: InputBorder.none,
                  ),
                )
              ],
            ),
          ),
        ),
        if (topLeftSticker != null)
          Positioned(
            left: -36,
            top: -36,
            child: IgnorePointer(
              child: RotateChild(
                rotationDegree: page.topLeftSticker!.rotationDegree,
                child: Image.memory(
                  topLeftSticker,
                  width: page.topLeftSticker!.width.toDouble(),
                  height: page.topLeftSticker!.height.toDouble(),
                ),
              ),
            ),
          ),
        if (topRightSticker != null)
          Positioned(
            right: -36,
            top: -36,
            child: IgnorePointer(
              child: RotateChild(
                rotationDegree: page.topRightSticker!.rotationDegree,
                child: Image.memory(
                  topRightSticker,
                  width: page.topRightSticker!.width.toDouble(),
                  height: page.topRightSticker!.height.toDouble(),
                ),
              ),
            ),
          ),
        if (bottomLeftSticker != null)
          Positioned(
            left: -36,
            bottom: -36,
            child: IgnorePointer(
              child: RotateChild(
                rotationDegree: page.bottomLeftSticker!.rotationDegree,
                child: Image.memory(
                  bottomLeftSticker,
                  width: page.bottomLeftSticker!.width.toDouble(),
                  height: page.bottomLeftSticker!.height.toDouble(),
                ),
              ),
            ),
          ),
        if (bottomRightSticker != null)
          Positioned(
            right: -36,
            bottom: -36,
            child: IgnorePointer(
              child: RotateChild(
                rotationDegree: page.bottomRightSticker!.rotationDegree,
                child: Image.memory(
                  bottomRightSticker,
                  width: page.bottomRightSticker!.width.toDouble(),
                  height: page.bottomRightSticker!.height.toDouble(),
                ),
              ),
            ),
          )
      ],
    );
  }
}
