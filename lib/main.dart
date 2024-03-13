import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:anime_app/provider/theme_provider/theme_provider.dart';
import 'package:anime_app/router/routes.dart';
import 'package:anime_app/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeProvider(
        duration: const Duration(seconds: 1),
        initTheme: lightThemeData(context.textTheme),
        builder: (context, theme) {
          return MaterialApp.router(
            routerConfig: router,
            theme: theme,
          );
        });
  }
}
