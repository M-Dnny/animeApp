import 'package:anime/provider/theme_provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          child: Image.asset(
              ref.watch(themeStateProvider) == ThemeMode.dark
                  ? "assets/images/logo_dark.png"
                  : "assets/images/logo.png",
              width: 100),
        ),
      ),
    );
  }
}

class LoadingShimmer extends ConsumerWidget {
  const LoadingShimmer({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
  });
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: SizedBox(
        height: height,
        width: width,
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          duration: const Duration(seconds: 2),
          blendMode: BlendMode.srcATop,
          angle: 0.5,
          size: 3,
          color: Colors.blueGrey.shade300,
        );
  }
}
