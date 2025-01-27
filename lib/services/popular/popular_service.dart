import 'dart:developer';

import 'package:anime/models/popular_model/popular_model.dart';
import 'package:anime/utils/config.dart';
import 'package:dio/dio.dart';

class PopularService {
  final dio = Dio();
  Future<List<PopularModel>> getPopular() async {
    try {
      const url = "$baseUrl$animeUrl/most-popular";

      log("Popular URL: $url");

      final result = await dio.get(url);

      if (result.statusCode == 200) {
        final popular = (result.data['results'] as List)
            .map((e) => PopularModel.fromJson(e))
            .toList();

        return popular;
      }

      return [];
    } catch (e) {
      log("Popular Error: $e");
      return [];
    }
  }
}
