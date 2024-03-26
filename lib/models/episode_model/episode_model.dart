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

class EpisodeSrcModel {
  final List<Track> tracks;
  final Intro intro;
  final Outro outro;
  final List<Source> sources;
  final int anilistID;
  final int malID;

  EpisodeSrcModel({
    required this.tracks,
    required this.intro,
    required this.outro,
    required this.sources,
    required this.anilistID,
    required this.malID,
  });

  factory EpisodeSrcModel.fromJson(Map<String, dynamic> json) {
    return EpisodeSrcModel(
      tracks:
          List<Track>.from(json['tracks']?.map((x) => Track.fromJson(x)) ?? []),
      intro: Intro.fromJson(json['intro']),
      outro: Outro.fromJson(json['outro']),
      sources: List<Source>.from(
          json['sources']?.map((x) => Source.fromJson(x)) ?? []),
      anilistID: json['anilistID'],
      malID: json['malID'],
    );
  }
}

class Track {
  final String file;
  final String kind;

  Track({required this.file, required this.kind});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      file: json['file'],
      kind: json['kind'],
    );
  }
}

class Intro {
  final int start;
  final int end;

  Intro({required this.start, required this.end});

  factory Intro.fromJson(Map<String, dynamic> json) {
    return Intro(
      start: json['start'],
      end: json['end'],
    );
  }
}

class Outro {
  final int start;
  final int end;

  Outro({required this.start, required this.end});

  factory Outro.fromJson(Map<String, dynamic> json) {
    return Outro(
      start: json['start'],
      end: json['end'],
    );
  }
}

class Source {
  final String url;
  final String type;

  Source({required this.url, required this.type});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      url: json['url'],
      type: json['type'],
    );
  }
}
