import 'package:anime_app/models/upcoming_model/upcoming_model.dart';
import 'package:anime_app/services/upcomings/upcoming_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final upcomingProvider = FutureProvider<List<UpcomingModel>>((ref) async {
  return UpcomingService().getUpcoming();
});
