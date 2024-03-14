import 'dart:developer';

import 'package:anime/models/top_airing_model/top_airing_model.dart';
import 'package:anime/utils/config.dart';
import 'package:dio/dio.dart';

class TopAiringService {
  final dio = Dio();

  Future<List<TopAiringModel>> getTopAiring() async {
    try {
      const url = "$baseUrl$animeUrl/top-airing";

      log("TopAiring URL: $url");

      final result = await dio.get(url);

      if (result.statusCode == 200) {
        final upcoming = (result.data['results'] as List)
            .map((e) => TopAiringModel.fromJson(e))
            .toList();

        return upcoming;
      }

      return [];
    } catch (e) {
      log("TopAiring Error: $e");
      return [];
    }
  }
}
