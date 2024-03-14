import 'package:anime/models/upcoming_model/upcoming_model.dart';
import 'package:anime/services/upcomings/upcoming_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final upcomingProvider = FutureProvider<List<UpcomingModel>>((ref) async {
  return UpcomingService().getUpcoming();
});
