import 'dart:developer';

import 'package:anime/models/episode_model/episode_model.dart';
import 'package:anime/utils/config.dart';
import 'package:dio/dio.dart';

class EpisodesService {
  final dio = Dio();
  Future<EpisodeSrcModel> getEpisodesSrc(
      {required String id, required String category}) async {
    try {
      final url = "$baseUrl$animeUrl/episode-srcs?id=$id&category=$category";

      log("getEpisodesSrc URL: $url");

      final result = await dio.get(url);

      if (result.statusCode == 200) {
        final res = EpisodeSrcModel.fromJson(result.data);

        return res;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      log("getEpisodesSrc Error: $e");
      rethrow;
    }
  }
}
