import 'package:flutter/material.dart';
import 'package:storypad_layout_builder/core/extensions/string_extension.dart';
import 'package:storypad_layout_builder/core/services/image_picker_service.dart';
import 'package:storypad_layout_builder/views/layouts/show/local_widgets/rotate_child.dart';
import 'package:storypad_layout_builder/views/layouts/show/story_page.dart';

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
                title: Text(entry.key.capitalize),
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
                                ),
                              );
                              break;
                            case 'Top right':
                              page = page.copyWithTopRightSticker(
                                Sticker(
                                  rotationDegree: value,
                                  imageKey: entry.value!.imageKey,
                                ),
                              );
                              break;
                            case 'Bottom left':
                              page = page.copyWithBottomLeftSticker(
                                Sticker(
                                  rotationDegree: value,
                                  imageKey: entry.value!.imageKey,
                                ),
                              );
                              break;
                            case 'Bottom right':
                              page = page.copyWithBottomRightSticker(
                                Sticker(
                                  rotationDegree: value,
                                  imageKey: entry.value!.imageKey,
                                ),
                              );
                              break;
                          }

                          setState(() {});
                        },
                      )
                    : null,
                trailing: entry.value == null
                    ? Icon(Icons.add)
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
                onTap: () async {
                  final key = await ImagePickerService().pick(context);
                  if (key == null) return;

                  switch (entry.key) {
                    case 'Top left':
                      page = page.copyWithTopLeftSticker(
                        Sticker(rotationDegree: 0, imageKey: key),
                      );
                      break;
                    case 'Top right':
                      page = page.copyWithTopRightSticker(
                        Sticker(rotationDegree: 0, imageKey: key),
                      );
                      break;
                    case 'Bottom left':
                      page = page.copyWithBottomLeftSticker(
                        Sticker(rotationDegree: 0, imageKey: key),
                      );
                      break;
                    case 'Bottom right':
                      page = page.copyWithBottomRightSticker(
                        Sticker(rotationDegree: 0, imageKey: key),
                      );
                      break;
                  }

                  setState(() {});
                },
              );
            }).toList(),
          ),
          FilledButton(
            child: Text("Save"),
            onPressed: () => Navigator.maybePop(context, page),
          )
        ],
      ),
    );
  }
}
