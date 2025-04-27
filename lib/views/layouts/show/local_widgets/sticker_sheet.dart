import 'package:flutter/material.dart';
import 'package:storypad_layout_builder/core/extensions/string_extension.dart';
import 'package:storypad_layout_builder/core/services/image_picker_service.dart';
import 'package:storypad_layout_builder/views/layouts/show/local_widgets/rotate_child.dart';
import 'package:storypad_layout_builder/views/layouts/show/story_page.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:storypad_layout_builder/views/theme/theme_view.dart';

class StickerSheet extends StatefulWidget {
  const StickerSheet({
    super.key,
    required this.page,
  });

  final StoryPage page;

  static Future<StoryPage?> showSheet(
    BuildContext context,
    StoryPage initialPage,
  ) async {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isDismissible: true,
      builder: (context) {
        return StickerSheet(page: initialPage);
      },
    );
  }

  @override
  State<StickerSheet> createState() => _StickerSheetState();
}

class _StickerSheetState extends State<StickerSheet> {
  late StoryPage page = widget.page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: {
              'Top left': page.topLeftSticker,
              'Top right': page.topRightSticker,
              'Bottom left': page.bottomLeftSticker,
              'Bottom right': page.bottomRightSticker,
            }.entries.map((entry) {
              final content = entry.value != null
                  ? ImagePickerService.getContent(entry.value!.imageKey)
                  : null;
              return ListTile(
                leading: SizedBox(
                  width: 64,
                  child: content != null
                      ? RotateChild(
                          rotationDegree: entry.value!.rotationDegree,
                          child: Image.memory(content),
                        )
                      : Icon(Icons.image_not_supported_outlined),
                ),
                title: Text(entry.value != null
                    ? "${entry.key.capitalize} ${entry.value?.width} / ${entry.value?.height}"
                    : entry.key.capitalize),
                subtitle: entry.value != null
                    ? Slider(
                        padding: EdgeInsets.zero,
                        min: 0,
                        max: 360,
                        value: entry.value?.rotationDegree ?? 0,
                        label: "${entry.value?.rotationDegree}",
                        divisions: 24,
                        onChanged: (value) {
                          switch (entry.key) {
                            case 'Top left':
                              page = page.copyWithTopLeftSticker(
                                Sticker(
                                  rotationDegree: value,
                                  imageKey: entry.value!.imageKey,
                                  width: entry.value!.width,
                                  height: entry.value!.height,
                                ),
                              );
                              break;
                            case 'Top right':
                              page = page.copyWithTopRightSticker(
                                Sticker(
                                  rotationDegree: value,
                                  imageKey: entry.value!.imageKey,
                                  width: entry.value!.width,
                                  height: entry.value!.height,
                                ),
                              );
                              break;
                            case 'Bottom left':
                              page = page.copyWithBottomLeftSticker(
                                Sticker(
                                  rotationDegree: value,
                                  imageKey: entry.value!.imageKey,
                                  width: entry.value!.width,
                                  height: entry.value!.height,
                                ),
                              );
                              break;
                            case 'Bottom right':
                              page = page.copyWithBottomRightSticker(
                                Sticker(
                                  rotationDegree: value,
                                  imageKey: entry.value!.imageKey,
                                  width: entry.value!.width,
                                  height: entry.value!.height,
                                ),
                              );
                              break;
                          }

                          setState(() {});
                        },
                      )
                    : null,
                trailing: entry.value == null
                    ? IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          final key = await ImagePickerService().pick(context);

                          if (key == null) return;

                          final content = ImagePickerService.getContent(key);
                          if (content == null) return;

                          final size = await getImageSize(content);

                          switch (entry.key) {
                            case 'Top left':
                              page = page.copyWithTopLeftSticker(
                                Sticker(
                                  rotationDegree: 0,
                                  imageKey: key,
                                  width: size.width,
                                  height: size.height,
                                ),
                              );
                              break;
                            case 'Top right':
                              page = page.copyWithTopRightSticker(
                                Sticker(
                                  rotationDegree: 0,
                                  imageKey: key,
                                  width: size.width,
                                  height: size.height,
                                ),
                              );
                              break;
                            case 'Bottom left':
                              page = page.copyWithBottomLeftSticker(
                                Sticker(
                                  rotationDegree: 0,
                                  imageKey: key,
                                  width: size.width,
                                  height: size.height,
                                ),
                              );
                              break;
                            case 'Bottom right':
                              page = page.copyWithBottomRightSticker(
                                Sticker(
                                  rotationDegree: 0,
                                  imageKey: key,
                                  width: size.width,
                                  height: size.height,
                                ),
                              );
                              break;
                          }

                          setState(() {});
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          switch (entry.key) {
                            case 'Top left':
                              page = page.copyWithTopLeftSticker(null);
                              break;
                            case 'Top right':
                              page = page.copyWithTopRightSticker(null);
                              break;
                            case 'Bottom left':
                              page = page.copyWithBottomLeftSticker(null);
                              break;
                            case 'Bottom right':
                              page = page.copyWithBottomRightSticker(null);
                              break;
                          }

                          setState(() {});
                        },
                      ),
              );
            }).toList(),
          ),
          Divider(),
          buildColorSeedTile(context),
          FilledButton(
            child: Text("Save"),
            onPressed: () => Navigator.maybePop(context, page),
          )
        ],
      ),
    );
  }

  Widget buildColorSeedTile(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        page = page.copyWithBackgroundColor(
          // ignore: deprecated_member_use
          value.value == page.backgroundSeedColor ? null : value.value,
        );
        setState(() {});
      },
      itemBuilder: (BuildContext context) {
        return kMaterialColors.map((color) {
          return PopupMenuItem(
            value: color,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              // ignore: deprecated_member_use
              child: color.value == page.backgroundSeedColor
                  ? Icon(Icons.check, color: Colors.white)
                  : null,
            ),
          );
        }).toList();
      },
      child: ListTile(
        leading: SizedBox(width: 64.0, child: Icon(Icons.color_lens)),
        title: Text("Background Color"),
        trailing: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: page.backgroundSeedColor != null
                  ? Color(page.backgroundSeedColor!)
                  : null,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

Future<ui.Image> loadImage(Uint8List imgBytes) async {
  final codec = await ui.instantiateImageCodec(imgBytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}

Future<ui.Image> getImageSize(Uint8List imgBytes) async {
  final image = await loadImage(imgBytes);
  return image;
}
