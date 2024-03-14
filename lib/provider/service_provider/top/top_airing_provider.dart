import 'package:anime/models/top_airing_model/top_airing_model.dart';
import 'package:anime/services/top/top_airing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final topAiringProvider = FutureProvider<List<TopAiringModel>>((ref) async {
  return TopAiringService().getTopAiring();
});
