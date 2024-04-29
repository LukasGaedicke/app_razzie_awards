class MovieModel {
  final int id;
  final int year;
  final String title;
  final List<String> studios;
  final List<String> producers;
  final bool winner;

  MovieModel({
    required this.id,
    required this.year,
    required this.title,
    required this.studios,
    required this.producers,
    required this.winner,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        year: json['year'],
        title: json['title'],
        studios: List<String>.from(json['studios'].map((x) => x)),
        producers: List<String>.from(json['producers'].map((x) => x)),
        winner: json['winner'],
      );

  toJson() => {
        'id': id,
        'year': year,
        'title': title,
        'studios': studios,
        'producers': producers,
        'winner': winner,
      };
}
