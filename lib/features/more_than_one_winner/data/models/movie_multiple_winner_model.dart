import '../../domains/entities/movie_multiple_winner.dart';

class MovieMultipleWinnerModel extends MovieMultipleWinner {
  const MovieMultipleWinnerModel(
      {required super.year, required super.winnerCount});

  factory MovieMultipleWinnerModel.fromJson(Map<String, dynamic> json) {
    return MovieMultipleWinnerModel(
      year: json['year'],
      winnerCount: json['winnerCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'winnerCount': winnerCount,
    };
  }
}
