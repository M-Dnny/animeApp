import 'dart:developer';

import 'package:anime_app/models/upcoming_model/upcoming_model.dart';
import 'package:anime_app/utils/config.dart';
import 'package:dio/dio.dart';

class UpcomingService {
  final dio = Dio();

  Future<List<UpcomingModel>> getUpcoming() async {
    try {
      const url = "$baseUrl$animeUrl$zoroUrl/top-upcoming";

      log("top-upcoming URL: $url");

      final result = await dio.get(url);

      if (result.statusCode == 200) {
        final upcoming = (result.data['results'] as List)
            .map((e) => UpcomingModel.fromJson(e))
            .toList();

        return upcoming;
      }

      return [];
    } catch (e) {
      log("Upcoming Error: $e");
      return [];
    }
  }
}
