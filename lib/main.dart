import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:anime/provider/theme_provider/theme_provider.dart';
import 'package:anime/router/routes.dart';
import 'package:anime/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ProviderScope(child: MainApp()));
  });
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initTheme = lightThemeData(context.textTheme);
    return ThemeProvider(
        duration: const Duration(seconds: 1),
        initTheme: initTheme,
        builder: (context, theme) {
          return MaterialApp.router(
            routerConfig: router,
            theme: theme,
          );
        });
  }
}
