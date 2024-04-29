import 'dart:async';

import 'package:app_golden_raspberry_awards/features/more_than_one_winner/domains/entities/movie_multiple_winner.dart';

abstract class MoviesMultipleWinnerRepository {
  FutureOr<List<MovieMultipleWinner>> getMoviesMultipleWinner();
}
