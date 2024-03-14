import 'dart:async';

import 'package:anime/services/internet_available.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkInternetAvailable();
    super.initState();
  }

  void checkInternetAvailable() async {
    var connectResult = await Connectivity().checkConnectivity();

    if (connectResult != ConnectivityResult.none) {
      if (await isInternetAvailable()) {
        Timer(const Duration(seconds: 5), () {
          context.go('/home');
        });
      } else {
        showError();
      }
    } else {
      showError();
    }
  }

  void showError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please check your internet settings.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Hero(
                tag: "logo",
                child: RippleAnimation(
                  color: const Color(0xFFAA3333),
                  delay: const Duration(milliseconds: 300),
                  repeat: true,
                  minRadius: 45,
                  ripplesCount: 5,
                  duration: const Duration(milliseconds: 6 * 300),
                  child: Image.asset("assets/images/logo_dark.png", width: 100),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
