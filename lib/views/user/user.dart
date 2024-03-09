import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_app/provider/service_provider/user_service_provider.dart';
import 'package:anime_app/provider/theme_provider/theme_provider.dart';
import 'package:anime_app/router/drawer_nav.dart';
import 'package:anime_app/utils/extentions.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen(this.userId, {super.key});
  final String userId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
  Widget build(BuildContext context) {
    var data = ref.watch(userInfoProvider(widget.userId));
    var themeMode = ref.watch(themeStateProvider);
    const lightMode = ThemeMode.light;
    const darkMode = ThemeMode.dark;
    return Scaffold(
        drawer: const DrawerWid(),
        appBar: AppBar(
          title: Text('User ID: ${widget.userId}'),
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  context.scaffoldContext.openDrawer();
                },
                icon: const Icon(Icons.menu));
          }),
          actions: [
            IconButton(
              onPressed: () {
                ref.watch(themeStateProvider.notifier).state =
                    themeMode == lightMode ? darkMode : lightMode;
              },
              icon: Icon(
                  themeMode == lightMode ? Icons.light_mode : Icons.dark_mode),
            )
          ],
        ),
        body: Center(
          child: data.when(
            data: (data) => SizedBox(
              width: 300,
              height: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            data!.name,
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                        Text(data.email,
                            style: context.textTheme.headlineSmall!
                                .copyWith(fontWeight: FontWeight.bold)),
                        Text(data.phone,
                            style: context.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        Text(data.website,
                            style: context.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
            ),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ));
  }
}
