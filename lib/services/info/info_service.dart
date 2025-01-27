// ignore_for_file: null_argument_to_non_null_type

import 'dart:developer';

import 'package:anime/models/episode_model/episode_model.dart';
import 'package:anime/models/info_model/info_model.dart';
import 'package:anime/provider/service_provider/info/info_provider.dart';
import 'package:anime/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoService {
  final dio = Dio();
  Future<AnimeInfoModel> getInfo({required FutureProviderRef ref}) async {
    try {
      final id = ref.watch(animeInfoIdProvider);
      final url = "$baseUrl$animeUrl/info?id=$id";

      log("Anime Info URL: $url");

      final result = await dio.get(url);

      if (result.statusCode == 200) {
        final res = AnimeInfoModel.fromJson(result.data);

        return res;
      } else {
        log(result.data.toString());
      }

      return Future.value();
    } catch (e) {
      log("Info Error: $e");
      return Future.value();
    }
  }

  Future<EpisodesModel> getEpisode({required FutureProviderRef ref}) async {
    try {
      final id = ref.watch(animeInfoIdProvider);
      final url = "$baseUrl$animeUrl/episodes/$id";

      log("Anime Episode URL: $url");

      final result = await dio.get(url);

      if (result.statusCode == 200) {
        final res = EpisodesModel.fromJson(result.data);
        return res;
      } else {
        log(result.data.toString());
      }

      return Future.value();
    } catch (e) {
      log("Info Error: $e");
      return Future.value();
    }
  }
}
