import 'package:anime/router/bottom_bar.dart';
import 'package:anime/views/detail/anime_detail.dart';
import 'package:anime/views/home/home.dart';
import 'package:anime/views/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/bottomBar',
      name: 'bottomBar',
      builder: (context, state) => const BottomBar(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/animeDetail',
      name: 'animeDetail',
      builder: (context, state) => const AnimeDetail(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
      body: Center(
    child: Text('No route defined for ${state.uri}'),
  )),
);
