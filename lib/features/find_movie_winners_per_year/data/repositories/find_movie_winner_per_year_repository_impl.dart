import 'dart:async';

import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/data/datasource/find_movie_winner_per_year_datasource.dart';
import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/data/model/movies_model.dart';
import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/domain/repositories/find_movie_winner_per_year_repository.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';

class FindMovieWinnerPerYearRepositoryImpl
    extends FindMovieWinnerPerYearRepository {
  FindMovieWinnerPerYearRepositoryImpl(this.remoteDatasource);

  final FindMovieWinnerPerYearDatasource remoteDatasource;

  @override
  Future<Movie> findMovieWinnerPerYear(int year) async {
    MovieModel movieModel = await remoteDatasource.getMovieWinnerPerYear(year);

    return Movie(
      id: movieModel.id,
      title: movieModel.title,
      year: movieModel.year,
      winner: movieModel.winner,
      studios: movieModel.studios,
      producers: movieModel.producers,
    );
  }
}
