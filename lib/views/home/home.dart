import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_app/provider/service_provider/user_service_provider.dart';
import 'package:anime_app/provider/theme_provider/theme_provider.dart';
import 'package:anime_app/utils/extentions.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var data = ref.watch(userListProvider);
    var themeMode = ref.watch(themeStateProvider);
    const lightMode = ThemeMode.light;
    const darkMode = ThemeMode.dark;

    changeTheme() {
      ref.watch(themeStateProvider.notifier).state =
          themeMode == lightMode ? darkMode : lightMode;
    }

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Home'),
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: () {
                changeTheme();
              },
              icon: Icon(
                  themeMode == lightMode ? Icons.light_mode : Icons.dark_mode))
        ],
      ),
      body: SafeArea(
        child: data.when(
          data: (data) {
            if (data == null || data.isEmpty) {
              return Center(
                  child: Text(
                'No data found🥲',
                style: context.textTheme.headlineMedium,
              ));
            }
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                      title: ElevatedButton(
                        onPressed: () {
                          context.pushNamed('user', pathParameters: {
                            'userId': data[index].id.toString()
                          });
                        },
                        child: Builder(builder: (context) {
                          return Text(
                            data[index].name,
                            style: context.textTheme.titleLarge,
                          );
                        }),
                      ),
                    ));
          },
          error: (error, stackTrace) => Center(
              child: Text(
            error.toString(),
          )),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class Bottom1 extends StatelessWidget {
  const Bottom1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Bottom 1',
        style: context.textTheme.headlineMedium,
      )),
    );
  }
}

class Bottom2 extends StatelessWidget { 
  const Bottom2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Bottom 2',
        style: context.textTheme.headlineMedium,
      )),
    );
  }
}
