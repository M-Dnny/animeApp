class BannerModel {
  final int rank;
  final String name;
  final String id;
  final String poster;

  BannerModel(
      {required this.rank,
      required this.name,
      required this.id,
      required this.poster});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      rank: json['rank'],
      name: json['name'],
      id: json['id'],
      poster: json['poster'],
    );
  }
}
