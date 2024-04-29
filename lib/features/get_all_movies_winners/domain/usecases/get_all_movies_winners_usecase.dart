import 'dart:async';

import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/domain/repositories/all_movies_winners_repository.dart';

class GetAllMoviesWinnersUseCase {
  late final AllMoviesWinnersRepository repository;

  GetAllMoviesWinnersUseCase({required this.repository});

  FutureOr<List<Movie>> execute(
      int page, int limit, List<dynamic> filters) async {
    String winnerFilterSelected = filters[0];
    int yearFilterSelected = filters[1];

    if (winnerFilterSelected == 'Yes') {
      return await repository.getAllMoviesWinners(page, limit,
          winner: true, year: yearFilterSelected);
    } else if (winnerFilterSelected == 'No') {
      return await repository.getAllMoviesWinners(page, limit,
          winner: false, year: yearFilterSelected);
    } else {
      return await repository.getAllMoviesWinners(page, limit,
          year: yearFilterSelected);
    }
  }
}
