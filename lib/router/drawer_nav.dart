import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_app/provider/router_provider/bottom_bar_provider.dart';
import 'package:anime_app/router/bottom_bar.dart';

class DrawerNav extends ConsumerStatefulWidget {
  const DrawerNav({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerNavState();
}

class _DrawerNavState extends ConsumerState<DrawerNav> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: DrawerWid(),
      body: BottomBar(),
    );
  }
}

class DrawerWid extends StatelessWidget {
  const DrawerWid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer(builder: (context, ref, child) {
      return ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              ref.watch(bottomBarProvider.notifier).state = 0;
              context.pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.south_america),
            title: const Text('Bottom1'),
            onTap: () {
              ref.watch(bottomBarProvider.notifier).state = 1;
              context.pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.ac_unit),
            title: const Text('Bottom2'),
            onTap: () {
              ref.watch(bottomBarProvider.notifier).state = 2;
              context.pop();
            },
          ),
        ],
      );
    }));
  }
}
