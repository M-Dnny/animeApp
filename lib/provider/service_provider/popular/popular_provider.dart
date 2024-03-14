import 'package:anime/models/popular_model/popular_model.dart';
import 'package:anime/services/popular/popular_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularProvider = FutureProvider<List<PopularModel>>((ref) async {
  return PopularService().getPopular();
});
