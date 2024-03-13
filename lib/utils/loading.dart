import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: RippleAnimation(
          color: const Color(0xFFAA3333),
          delay: const Duration(milliseconds: 100),
          repeat: true,
          minRadius: 45,
          ripplesCount: 5,
          duration: const Duration(milliseconds: 6 * 300),
          child: Image.asset("assets/images/logo.png", width: 100),
        ),
      ),
    );
  }
}
