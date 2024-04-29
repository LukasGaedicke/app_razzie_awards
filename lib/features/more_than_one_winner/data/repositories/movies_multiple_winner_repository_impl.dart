import 'dart:async';

import 'package:app_golden_raspberry_awards/features/more_than_one_winner/domains/entities/movie_multiple_winner.dart';

import '../../domains/repositories/movies_multiple_winner_repository.dart';
import '../datasource/movie_multiple_winner_remote_datasource.dart';

class MoviesMultipleWinnerRepositoryImpl
    extends MoviesMultipleWinnerRepository {
  MoviesMultipleWinnerRepositoryImpl(this.remoteDatasource);

  final MovieMultipleWinnerRemoteDatasource remoteDatasource;

  @override
  FutureOr<List<MovieMultipleWinner>> getMoviesMultipleWinner() async {
    final moviesMultipleWinnerListModel =
        await remoteDatasource.getMoviesMultipleWinner();

    List<MovieMultipleWinner> newList = moviesMultipleWinnerListModel
        .moviesMultipleWinner
        .map((e) =>
            MovieMultipleWinner(year: e.year, winnerCount: e.winnerCount))
        .toList();

    return newList;
  }
}
