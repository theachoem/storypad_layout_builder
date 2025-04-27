// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class ImagePickerService {
  static Uint8List? getContent(String key) {
    final result = web.window.localStorage.getItem(key);
    if (result != null) {
      final list = jsonDecode(result);
      if (list is List) {
        return Uint8List.fromList(list.whereType<int>().toList());
      }
    }
    return null;
  }

  Future<String?> pick(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      showDragHandle: false,
      builder: (context) {
        return DraggableScrollableSheet(builder: (context, controller) {
          return PrimaryScrollController(
            controller: controller,
            child: _ImagePickerSheet(),
          );
        });
      },
    );
  }
}

class _ImagePickerSheet extends StatefulWidget {
  const _ImagePickerSheet();

  @override
  State<_ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<_ImagePickerSheet> {
  void pick() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (result?.files.isNotEmpty == true) {
      for (final file in result?.files ?? <PlatformFile>[]) {
        web.window.localStorage.setItem(
          "images-${DateTime.now().millisecondsSinceEpoch}",
          jsonEncode(file.bytes?.toList()),
        );
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<String> keys = [];
    for (int i = 0; i < 100000; i++) {
      final key = web.window.localStorage.key(i);

      if (key != null && key.startsWith("images")) {
        keys.add(key);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Select an image below"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => pick(),
          )
        ],
      ),
      body: ListView.builder(
        controller: PrimaryScrollController.maybeOf(context),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          final key = keys[index];
          final result = web.window.localStorage.getItem(key);

          List? result1 = result != null ? jsonDecode(result) : null;
          List<int>? filtered =
              result1 is List ? result1.whereType<int>().toList() : null;
          final bytes = filtered != null ? Uint8List.fromList(filtered) : null;

          return ListTile(
            onTap: () => Navigator.maybePop(context, key),
            leading: bytes != null
                ? Image.memory(bytes)
                : Icon(Icons.device_unknown),
            title: Text(key),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final sure = web.window.confirm("Are you sure?");
                if (sure) {
                  web.window.localStorage.removeItem(key);
                  setState(() {});
                }
              },
            ),
          );
        },
      ),
    );
  }
}
