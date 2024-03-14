import 'package:anime/models/info_model/info_model.dart';
import 'package:anime/services/info/info_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animeInfoIdProvider = StateProvider<String>((ref) {
  return "";
});

final animeInfoProvider = FutureProvider<AnimeInfoModel>((ref) async {
  return InfoService().getInfo(ref: ref);
});
