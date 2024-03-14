import 'package:anime/models/home_model/home_model.dart';
import 'package:anime/services/home/home_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = FutureProvider<HomeModel>((ref) async {
  return HomeService().getHomeData();
});
