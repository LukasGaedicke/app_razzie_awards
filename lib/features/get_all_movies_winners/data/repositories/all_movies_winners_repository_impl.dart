import 'dart:async';

import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/datasource/all_movies_winners_remote_datasource.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/domain/repositories/all_movies_winners_repository.dart';

class AllMoviesWinnersRepositoryImpl extends AllMoviesWinnersRepository {
  AllMoviesWinnersRepositoryImpl(this.remoteDatasource);

  final AllMoviesRemoteDatasource remoteDatasource;

  @override
  FutureOr<List<Movie>> getAllMoviesWinners(int page, int limit,
      {bool? winner, int? year}) async {
    final allMoviesWinnersModel = await remoteDatasource
        .getAllMoviesWinners(page, limit, winner: winner, year: year);

    return allMoviesWinnersModel.content;
  }
}
