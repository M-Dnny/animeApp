class EpisodesModel {
  final int totalEpisodes;
  final List<Episode> episodes;

  EpisodesModel({required this.totalEpisodes, required this.episodes});

  factory EpisodesModel.fromJson(Map<String, dynamic> json) {
    return EpisodesModel(
      totalEpisodes: json['totalEpisodes'],
      episodes: List<Episode>.from(
        json['episodes']?.map((x) => Episode.fromJson(x)) ?? [],
      ),
    );
  }
}

class Episode {
  final String title;
  final String episodeId;
  final int number;
  final bool isFiller;

  Episode({
    required this.title,
    required this.episodeId,
    required this.number,
    required this.isFiller,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      title: json['title'],
      episodeId: json['episodeId'],
      number: json['number'],
      isFiller: json['isFiller'],
    );
  }
}
