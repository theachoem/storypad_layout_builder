import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storypad_layout_builder/app_theme.dart';
import 'package:storypad_layout_builder/core/extensions/string_extension.dart';
import 'package:storypad_layout_builder/providers/theme_provider.dart';

const List<ColorSwatch> kMaterialColors = <ColorSwatch>[
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
];

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildThemeModeTile(themeProvider),
          buildColorSeedTile(themeProvider, context),
          buildFontFamilyTile(themeProvider, context),
        ],
      ),
    );
  }

  Widget buildFontFamilyTile(
    ThemeProvider themeProvider,
    BuildContext context,
  ) {
    return ListTile(
      title: Text("Font Family"),
      subtitle: Text(themeProvider.fontFamily),
      onTap: () {
        showSearch(context: context, delegate: _FontSearch());
      },
    );
  }

  Widget buildColorSeedTile(ThemeProvider themeProvider, BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) => themeProvider.setColorSeed(value),
      itemBuilder: (BuildContext context) {
        return kMaterialColors.map((color) {
          return PopupMenuItem(
            value: color,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color:
                    color == Colors.black && AppTheme.isDarkMode(context)
                        ? Colors.white
                        : color,
                shape: BoxShape.circle,
              ),
              child:
                  color == themeProvider.colorSeed
                      ? Icon(Icons.check, color: Colors.black45)
                      : null,
            ),
          );
        }).toList();
      },
      child: ListTile(
        title: Text("Color Seed"),
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
              color:
                  themeProvider.colorSeed == Colors.black &&
                          AppTheme.isDarkMode(context)
                      ? Colors.white
                      : themeProvider.colorSeed,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildThemeModeTile(ThemeProvider themeProvider) {
    return PopupMenuButton(
      onSelected: (value) => themeProvider.setThemeMode(value),
      itemBuilder: (BuildContext context) {
        return ThemeMode.values.map((e) {
          return PopupMenuItem(value: e, child: Text(e.name.capitalize));
        }).toList();
      },
      child: ListTile(
        title: Text("Theme Mode"),
        subtitle: Text(themeProvider.themeMode.name.capitalize),
      ),
    );
  }
}

class _FontSearch extends SearchDelegate {
  late final Iterable<String> fonts = GoogleFonts.asMap().keys;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return CloseButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: fonts.length,
      itemBuilder: (context, index) {
        final font = fonts.elementAt(index);
        return buildFontFamilyTile(context, font);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = fonts.where(
      (e) => e.toLowerCase().contains(query.trim().toLowerCase()),
    );
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        final font = result.elementAt(index);
        return buildFontFamilyTile(context, font);
      },
    );
  }

  Widget buildFontFamilyTile(BuildContext context, String font) {
    return PopupMenuButton(
      onSelected: (value) => context.read<ThemeProvider>().setFontFamily(font),
      child: ListTile(title: Text(font)),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: font,
            child: ListTile(
              title: Text("Use this font"),
              subtitle: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consequat nunc.",
                style: GoogleFonts.getFont(font),
              ),
            ),
          ),
        ];
      },
    );
  }
}
