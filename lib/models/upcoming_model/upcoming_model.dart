class UpcomingModel {
  String id;
  String name;
  String poster;
  String duration;
  String type;
  String rating;
  int rank;
  Episode episode;

  UpcomingModel({
    required this.id,
    required this.name,
    required this.poster,
    required this.duration,
    required this.type,
    required this.rating,
    required this.rank,
    required this.episode,
  });

  factory UpcomingModel.fromJson(Map<String, dynamic> json) {
    return UpcomingModel(
      id: json['id'],
      name: json['name'],
      poster: json['poster'],
      duration: json['duration'] ?? "",
      type: json['type'] ?? "",
      rating: json['rating'] ?? "",
      rank: json['rank'] ?? 0,
      episode: Episode.fromJson(json['episodes']),
    );
  }
}

class Episode {
  int sub;
  int dub;

  Episode({required this.sub, required this.dub});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      sub: json['sub'] ?? 0,
      dub: json['dub'] == null ? 0 : json['dub'] ?? 0,
    );
  }
}
