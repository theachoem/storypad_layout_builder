import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storypad_layout_builder/providers/theme_provider.dart';

class AppTheme extends StatelessWidget {
  const AppTheme({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    ThemeData theme,
    ThemeData darkTheme,
    ThemeMode themeMode,
  )
  builder;

  // default text direction
  static bool ltr(BuildContext context) =>
      Directionality.of(context) == TextDirection.ltr;
  static bool rtl(BuildContext context) =>
      Directionality.of(context) == TextDirection.rtl;
  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static bool isMonochrome(BuildContext context) =>
      context.read<ThemeProvider>().colorSeed == Colors.black ||
      context.read<ThemeProvider>().colorSeed == Colors.white;

  static FontWeight getThemeFontWeight(
    BuildContext context,
    FontWeight fontWeight,
  ) {
    return calculateFontWeight(
      fontWeight,
      context.read<ThemeProvider>().fontWeight,
    );
  }

  static T? getDirectionValue<T extends Object>(
    BuildContext context,
    T? rtlValue,
    T? ltrValue,
  ) {
    if (Directionality.of(context) == TextDirection.rtl) {
      return rtlValue;
    } else {
      return ltrValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return buildColorScheme(
          provider: provider,
          builder: (ColorScheme lightScheme, ColorScheme darkScheme) {
            final theme = getTheme(
              colorScheme: lightScheme,
              fontFamily: provider.fontFamily,
              fontWeight: provider.fontWeight,
            );

            final darkTheme = getTheme(
              colorScheme: darkScheme,
              fontFamily: provider.fontFamily,
              fontWeight: provider.fontWeight,
            );

            return builder(context, theme, darkTheme, provider.themeMode);
          },
        );
      },
    );
  }

  static ThemeData getTheme({
    required ColorScheme colorScheme,
    required String fontFamily,
    required FontWeight fontWeight,
    Color? scaffoldBackgroundColor,
  }) {
    scaffoldBackgroundColor ??= colorScheme.surface;
    bool darkMode = colorScheme.brightness == Brightness.dark;
    ThemeData baseTheme = darkMode ? ThemeData.dark() : ThemeData.light();

    TextStyle calculateTextStyle(
      TextStyle textStyle,
      FontWeight defaultFontWeight,
    ) {
      return textStyle.copyWith(
        fontWeight: calculateFontWeight(defaultFontWeight, fontWeight),
      );
    }

    Color? dividerColor = colorScheme.onSurface.withValues(alpha: 0.15);

    return baseTheme.copyWith(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: colorScheme,
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: colorScheme.brightness,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        primaryColor: colorScheme.primary,
        primaryContrastingColor: colorScheme.onPrimary,
        textTheme: CupertinoTextThemeData(primaryColor: colorScheme.primary),
      ),
      tabBarTheme: TabBarTheme(dividerColor: dividerColor),
      drawerTheme: const DrawerThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        endShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      dividerColor: dividerColor,
      dividerTheme: DividerThemeData(color: dividerColor),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(side: BorderSide(color: dividerColor)),
      ),
      textTheme: GoogleFonts.getTextTheme(
        fontFamily,
        TextTheme(
          displayLarge: calculateTextStyle(
            baseTheme.textTheme.displayLarge!,
            FontWeight.w400,
          ),
          displayMedium: calculateTextStyle(
            baseTheme.textTheme.displayMedium!,
            FontWeight.w400,
          ),
          displaySmall: calculateTextStyle(
            baseTheme.textTheme.displaySmall!,
            FontWeight.w400,
          ),
          headlineLarge: calculateTextStyle(
            baseTheme.textTheme.headlineLarge!,
            FontWeight.w400,
          ),
          headlineMedium: calculateTextStyle(
            baseTheme.textTheme.headlineMedium!,
            FontWeight.w400,
          ),
          headlineSmall: calculateTextStyle(
            baseTheme.textTheme.headlineSmall!,
            FontWeight.w400,
          ),
          titleLarge: calculateTextStyle(
            baseTheme.textTheme.titleLarge!,
            FontWeight.w400,
          ),
          titleMedium: calculateTextStyle(
            baseTheme.textTheme.titleMedium!,
            FontWeight.w400,
          ),
          titleSmall: calculateTextStyle(
            baseTheme.textTheme.titleSmall!,
            FontWeight.w500,
          ),
          bodyLarge: calculateTextStyle(
            baseTheme.textTheme.bodyLarge!,
            FontWeight.w400,
          ),
          bodyMedium: calculateTextStyle(
            baseTheme.textTheme.bodyMedium!,
            FontWeight.w400,
          ),
          bodySmall: calculateTextStyle(
            baseTheme.textTheme.bodySmall!,
            FontWeight.w400,
          ),
          labelLarge: calculateTextStyle(
            baseTheme.textTheme.labelLarge!,
            FontWeight.w500,
          ),
          labelMedium: calculateTextStyle(
            baseTheme.textTheme.labelMedium!,
            FontWeight.w500,
          ),
          labelSmall: calculateTextStyle(
            baseTheme.textTheme.labelSmall!,
            FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildColorScheme({
    required ThemeProvider provider,
    required Widget Function(ColorScheme lightScheme, ColorScheme darkScheme)
    builder,
  }) {
    bool monochrome =
        provider.colorSeed == Colors.black ||
        provider.colorSeed == Colors.white;

    ColorScheme lightScheme = ColorScheme.fromSeed(
      seedColor: provider.colorSeed,
      brightness: Brightness.light,
      dynamicSchemeVariant:
          monochrome
              ? DynamicSchemeVariant.monochrome
              : DynamicSchemeVariant.tonalSpot,
    );

    ColorScheme darkScheme = ColorScheme.fromSeed(
      seedColor: provider.colorSeed,
      brightness: Brightness.dark,
      dynamicSchemeVariant:
          monochrome
              ? DynamicSchemeVariant.monochrome
              : DynamicSchemeVariant.tonalSpot,
    );

    return builder(lightScheme, darkScheme);
  }

  static FontWeight calculateFontWeight(
    FontWeight defaultWeight,
    FontWeight currentWeight,
  ) {
    int changeBy = defaultWeight == FontWeight.w400 ? 0 : 1;
    Map<int, FontWeight> fontWeights = {
      0: FontWeight.w100,
      1: FontWeight.w200,
      2: FontWeight.w300,
      3: FontWeight.w400,
      4: FontWeight.w500,
      5: FontWeight.w600,
      6: FontWeight.w700,
      7: FontWeight.w800,
      8: FontWeight.w900,
    };
    int index = currentWeight.index + changeBy;
    return fontWeights[math.max(math.min(8, index), 0)]!;
  }
}
