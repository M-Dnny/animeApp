class TopAiringModel {
  final String id;
  final String title;
  final String url;
  final String image;
  final String duration;
  final String japaneseTitle;
  final String type;
  final bool nsfw;
  final int sub;
  final int dub;
  final int episodes;

  TopAiringModel({
    required this.id,
    required this.title,
    required this.url,
    required this.image,
    required this.duration,
    required this.japaneseTitle,
    required this.type,
    required this.nsfw,
    required this.sub,
    required this.dub,
    required this.episodes,
  });

  factory TopAiringModel.fromJson(Map<String, dynamic> json) {
    return TopAiringModel(
      id: json["id"],
      title: json["title"],
      url: json["url"],
      image: json["image"],
      duration: json["duration"],
      japaneseTitle: json["japaneseTitle"],
      type: json["type"],
      nsfw: json["nsfw"],
      sub: json["sub"],
      dub: json["dub"],
      episodes: json["episodes"],
    );
  }
}
