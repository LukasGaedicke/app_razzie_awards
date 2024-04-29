import 'dart:async';

import 'package:app_golden_raspberry_awards/features/more_than_one_winner/domains/repositories/movies_multiple_winner_repository.dart';

import '../entities/movie_multiple_winner.dart';

class GetMoviesMultipleWinnerUseCase {
  late final MoviesMultipleWinnerRepository repository;

  GetMoviesMultipleWinnerUseCase({required this.repository});

  FutureOr<List<MovieMultipleWinner>> execute() async {
    return await repository.getMoviesMultipleWinner();
  }
}
