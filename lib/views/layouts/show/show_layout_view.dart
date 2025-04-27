import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:storypad_layout_builder/core/services/image_picker_service.dart';
import 'package:storypad_layout_builder/views/layouts/show/story_page.dart';
import 'package:storypad_layout_builder/views/layouts/show/local_widgets/story_pages_builder.dart';
import 'package:storypad_layout_builder/widgets/story_header.dart';
import 'package:storypad_layout_builder/widgets/theme_button.dart';

// ignore: depend_on_referenced_packages
import 'package:web/web.dart' as web;

class ShowLayoutView extends StatefulWidget {
  const ShowLayoutView({
    super.key,
  });

  @override
  State<ShowLayoutView> createState() => _ShowLayoutViewState();
}

class _ShowLayoutViewState extends State<ShowLayoutView> {
  int? selectedPage;

  Sticker? getPageSticker(int pageIndex, Alignment alignment) {
    String key = "stickers-$pageIndex-$alignment";
    final result = web.window.localStorage.getItem(key);

    if (result != null) {
      final Map data = jsonDecode(result);
      double? rotationDegree = data['rotationDegree'] != null
          ? double.tryParse(data['rotationDegree'].toString())
          : null;
      String? imageKey = data['imageKey'];

      if (rotationDegree != null && imageKey != null) {
        return Sticker(
          rotationDegree: rotationDegree,
          imageKey: imageKey,
        );
      }
    }

    return null;
  }

  void change(int index, StoryPage page) {
    String key1 = "stickers-$index-${Alignment.topLeft}";
    String key2 = "stickers-$index-${Alignment.topRight}";
    String key3 = "stickers-$index-${Alignment.bottomLeft}";
    String key4 = "stickers-$index-${Alignment.bottomRight}";

    if (page.topLeftSticker != null) {
      web.window.localStorage.setItem(
        key1,
        jsonEncode({
          'rotationDegree': page.topLeftSticker!.rotationDegree,
          'imageKey': page.topLeftSticker!.imageKey,
        }),
      );
    } else {
      web.window.localStorage.removeItem(key1);
    }

    if (page.topRightSticker != null) {
      web.window.localStorage.setItem(
        key2,
        jsonEncode({
          'rotationDegree': page.topRightSticker!.rotationDegree,
          'imageKey': page.topRightSticker!.imageKey,
        }),
      );
    } else {
      web.window.localStorage.removeItem(key2);
    }

    if (page.bottomLeftSticker != null) {
      web.window.localStorage.setItem(
        key3,
        jsonEncode({
          'rotationDegree': page.bottomLeftSticker!.rotationDegree,
          'imageKey': page.bottomLeftSticker!.imageKey,
        }),
      );
    } else {
      web.window.localStorage.removeItem(key3);
    }

    if (page.bottomRightSticker != null) {
      web.window.localStorage.setItem(
        key4,
        jsonEncode({
          'rotationDegree': page.bottomRightSticker!.rotationDegree,
          'imageKey': page.bottomRightSticker!.imageKey,
        }),
      );
    } else {
      web.window.localStorage.removeItem(key4);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: Icon(Icons.image_search),
          onPressed: () async {
            final key = await ImagePickerService().pick(context);
            debugPrint(key);
          },
        ),
        ThemeButton(),
      ]),
      body: StoryPagesBuilder(
        header: StoryHeader(),
        layoutType: StoryPagesLayoutType.grid1,
        onChanged: (int pageIndex, StoryPage newPage) {
          change(pageIndex, newPage);
        },
        pages: [
          StoryPage(
            title: "What am I thankful for today?",
            body: [
              "I'm grateful for the people in my life",
              "Something small that made me smile",
              "I'm grateful for the people in my life Something small that made me smile A person who made my day better today.",
            ].join("\n"),
            topLeftSticker: getPageSticker(0, Alignment.topLeft),
            topRightSticker: getPageSticker(0, Alignment.topRight),
            bottomLeftSticker: getPageSticker(0, Alignment.bottomLeft),
            bottomRightSticker: getPageSticker(0, Alignment.bottomRight),
          ),
          StoryPage(
            title: "What did today teach me?",
            body: [
              "I realized that taking breaks during the day",
              "I learned that I need to communicate",
              "I want to improve on being more patient with myself",
            ].join("\n"),
            topLeftSticker: getPageSticker(1, Alignment.topLeft),
            topRightSticker: getPageSticker(1, Alignment.topRight),
            bottomLeftSticker: getPageSticker(1, Alignment.bottomLeft),
            bottomRightSticker: getPageSticker(1, Alignment.bottomRight),
          ),
          StoryPage(
            title: "What moments made today special?",
            body: [
              "The best part of my day was having dinner",
              "A moment I want to remember oranges and pinks.",
              "Something that surprised me today was an unexpected message from an old friend.",
            ].join("\n"),
            topLeftSticker: getPageSticker(2, Alignment.topLeft),
            topRightSticker: getPageSticker(2, Alignment.topRight),
            bottomLeftSticker: getPageSticker(2, Alignment.bottomLeft),
            bottomRightSticker: getPageSticker(2, Alignment.bottomRight),
          ),
          StoryPage(
            title: "What am I thankful for today?",
            body: [
              "I'm grateful for the people in my life",
              "Something small that made me smile",
              "A person who made my day better today.",
            ].join("\n"),
            topLeftSticker: getPageSticker(3, Alignment.topLeft),
            topRightSticker: getPageSticker(3, Alignment.topRight),
            bottomLeftSticker: getPageSticker(3, Alignment.bottomLeft),
            bottomRightSticker: getPageSticker(3, Alignment.bottomRight),
          ),
        ],
      ),
    );
  }
}
