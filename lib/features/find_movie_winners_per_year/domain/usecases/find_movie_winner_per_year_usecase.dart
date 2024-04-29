import 'dart:async';

import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/domain/repositories/find_movie_winner_per_year_repository.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';

class FindMovieWinnerPerYearUseCase {
  late final FindMovieWinnerPerYearRepository repository;

  FindMovieWinnerPerYearUseCase({required this.repository});

  Future<Movie> execute(int year) async {
    return await repository.findMovieWinnerPerYear(year);
  }
}
