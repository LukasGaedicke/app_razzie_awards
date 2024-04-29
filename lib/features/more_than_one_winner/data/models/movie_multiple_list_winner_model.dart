import 'package:app_golden_raspberry_awards/features/more_than_one_winner/data/models/movie_multiple_winner_model.dart';

class MovieMultipleWinnerListModel {
  List<MovieMultipleWinnerModel> moviesMultipleWinner;

  MovieMultipleWinnerListModel({required this.moviesMultipleWinner});

  factory MovieMultipleWinnerListModel.fromJson(Map<String, dynamic> json) {
    return MovieMultipleWinnerListModel(
        moviesMultipleWinner: List<MovieMultipleWinnerModel>.from(
            json['years'].map((x) => MovieMultipleWinnerModel.fromJson(x))));
  }

  List<Map<String, dynamic>> toJson() {
    return moviesMultipleWinner.map((e) => e.toJson()).toList();
  }
}
