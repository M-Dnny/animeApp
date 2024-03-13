class AnimeInfoModel {
  final String id;
  final String title;
  final int malID;
  final int alID;
  final String image;
  final String description;
  final String type;
  final String url;
  final String subOrDub;
  final bool hasSub;
  final bool hasDub;
  final int totalEpisodes;
  final List<Episode> episodes;

  AnimeInfoModel({
    required this.id,
    required this.title,
    required this.malID,
    required this.alID,
    required this.image,
    required this.description,
    required this.type,
    required this.url,
    required this.subOrDub,
    required this.hasSub,
    required this.hasDub,
    required this.totalEpisodes,
    required this.episodes,
  });

  factory AnimeInfoModel.fromJson(Map<String, dynamic> json) {
    final episodes = <Episode>[];
    for (final episodeJson in json['episodes']) {
      episodes.add(Episode.fromJson(episodeJson));
    }

    return AnimeInfoModel(
      id: json['id'],
      title: json['title'],
      malID: json['malID'],
      alID: json['alID'],
      image: json['image'],
      description: json['description'],
      type: json['type'],
      url: json['url'],
      subOrDub: json['subOrDub'],
      hasSub: json['hasSub'],
      hasDub: json['hasDub'],
      totalEpisodes: json['totalEpisodes'],
      episodes: episodes,
    );
  }
}

class Episode {
  final String id;
  final int number;
  final String title;
  final bool isFiller;
  final String url;

  Episode({
    required this.id,
    required this.number,
    required this.title,
    required this.isFiller,
    required this.url,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      number: json['number'],
      title: json['title'],
      isFiller: json['isFiller'],
      url: json['url'],
    );
  }
}
