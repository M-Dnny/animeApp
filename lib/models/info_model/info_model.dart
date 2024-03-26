class AnimeInfoModel {
  InfoModel info;
  MoreInfoModel moreInfo;
  List<SeasonModel> seasonModel;

  AnimeInfoModel({
    required this.info,
    required this.moreInfo,
    required this.seasonModel,
  });

  factory AnimeInfoModel.fromJson(Map<String, dynamic> json) {
    return AnimeInfoModel(
      info: InfoModel.fromJson(json['anime']["info"]),
      moreInfo: MoreInfoModel.fromJson(json['anime']["moreInfo"]),
      seasonModel: json["seasons"] == null
          ? <SeasonModel>[]
          : List<SeasonModel>.from(
              json["seasons"].map((e) => SeasonModel.fromJson(e))),
    );
  }
}

class InfoModel {
  final String id;
  final String name;
  final String poster;
  final String description;
  final StatsModel stats;

  InfoModel({
    required this.id,
    required this.name,
    required this.poster,
    required this.description,
    required this.stats,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      id: json["id"] ?? "",
      name: json["name"],
      poster: json["poster"],
      description: json["description"] ?? "",
      stats: StatsModel.fromJson(json["stats"]),
    );
  }
}

class StatsModel {
  final String rating;
  final String quality;
  final EpisodeModel episodes;
  final String type;
  final String duration;

  StatsModel({
    required this.rating,
    required this.quality,
    required this.episodes,
    required this.type,
    required this.duration,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      rating: json["rating"],
      quality: json["quality"],
      episodes: EpisodeModel.fromJson(json["episodes"]),
      type: json["type"],
      duration: json["duration"],
    );
  }
}

class EpisodeModel {
  final int sub;
  final int dub;

  EpisodeModel({required this.sub, required this.dub});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      sub: json["sub"] ?? 0,
      dub: json["dub"] ?? 0,
    );
  }
}

class MoreInfoModel {
  final String japanese;
  final String synonyms;
  final String aired;
  final String premiered;
  final String duration;
  final String status;
  final String malscore;
  final List<String> genres;
  final String studios;
  final List<String> producers;

  MoreInfoModel({
    required this.japanese,
    required this.synonyms,
    required this.aired,
    required this.premiered,
    required this.duration,
    required this.status,
    required this.malscore,
    required this.genres,
    required this.studios,
    required this.producers,
  });

  factory MoreInfoModel.fromJson(Map<String, dynamic> json) {
    return MoreInfoModel(
      japanese: json["japanese"],
      synonyms: json["synonyms"] ?? "",
      aired: json["aired"],
      premiered: json["premiered"],
      duration: json["duration"],
      status: json["status"],
      malscore: json["malscore"],
      genres: List<String>.from(json["genres"]),
      studios: json["studios"] ?? "",
      producers: List<String>.from(json["producers"] ?? []),
    );
  }
}

class SeasonModel {
  final String id;
  final String name;
  final String title;
  final String poster;
  final bool isCurrent;

  SeasonModel({
    required this.id,
    required this.name,
    required this.title,
    required this.poster,
    required this.isCurrent,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      id: json["id"],
      name: json["name"],
      title: json["title"],
      poster: json["poster"],
      isCurrent: json["isCurrent"],
    );
  }

  SeasonModel copyWith({
    String? id,
    String? name,
    String? title,
    String? poster,
    bool? isCurrent,
  }) {
    return SeasonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      poster: poster ?? this.poster,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}
