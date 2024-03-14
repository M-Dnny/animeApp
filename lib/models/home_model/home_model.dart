import 'package:anime/models/banner/banner_model.dart';
import 'package:anime/models/upcoming_model/upcoming_model.dart';

class HomeModel {
  List<BannerModel> banners;
  List<UpcomingModel> upcoming;
  List<UpcomingModel> topAiring;

  HomeModel({
    required this.banners,
    required this.upcoming,
    required this.topAiring,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      banners: List<BannerModel>.from(
          json["trendingAnimes"].map((x) => BannerModel.fromJson(x))),
      upcoming: List<UpcomingModel>.from(
          json["topUpcomingAnimes"].map((x) => UpcomingModel.fromJson(x))),
      topAiring: List<UpcomingModel>.from(
          json["top10Animes"]["today"].map((x) => UpcomingModel.fromJson(x))),
    );
  }
}
