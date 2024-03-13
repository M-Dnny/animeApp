import 'package:anime_app/models/popular_model/popular_model.dart';
import 'package:anime_app/services/popular/popular_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularProvider = FutureProvider<List<PopularModel>>((ref) async {
  return PopularService().getPopular();
});
