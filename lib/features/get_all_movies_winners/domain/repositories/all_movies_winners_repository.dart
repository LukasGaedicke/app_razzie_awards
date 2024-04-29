import 'dart:async';

import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';

abstract class AllMoviesWinnersRepository {
  FutureOr<List<Movie>> getAllMoviesWinners(int page, int limit,
      {bool? winner, int? year});
}
