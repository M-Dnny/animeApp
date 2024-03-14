import 'package:anime/provider/router_provider/bottom_bar_provider.dart';
import 'package:anime/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    var index = ref.watch(bottomBarProvider);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (value) => {
          ref.read(bottomBarProvider.notifier).state = value,
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: '',
          ),
        ],
      ),
      body: [
        const HomeScreen(),
      ][index],
    );
  }
}
