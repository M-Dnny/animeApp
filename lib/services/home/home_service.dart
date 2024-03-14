// ignore_for_file: null_argument_to_non_null_type

import 'dart:developer';

import 'package:anime/models/home_model/home_model.dart';
import 'package:anime/utils/config.dart';
import 'package:dio/dio.dart';

class HomeService {
  final dio = Dio();
  Future<HomeModel> getHomeData() async {
    try {
      const url = "$baseUrl$animeUrl/home";

      log("Home URL: $url");

      final result = await dio.get(url);

      if (result.statusCode == 200) {
        final res = HomeModel.fromJson(result.data);

        return res;
      }

      return Future.value();
    } catch (e) {
      log("Home Error: $e");
      return Future.value();
    }
  }
}
