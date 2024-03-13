import 'package:anime_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final themeStateProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.light;
});

lightThemeData(TextTheme textTheme) => ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      textTheme: GoogleFonts.lailaTextTheme(textTheme).apply(
          bodyColor: lightColorScheme.inverseSurface,
          displayColor: lightColorScheme.inverseSurface),
    );
darkThemeData(TextTheme textTheme) => ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      textTheme: GoogleFonts.lailaTextTheme(textTheme).apply(
        bodyColor: darkColorScheme.surface,
        displayColor: darkColorScheme.surface,
      ),
    );
