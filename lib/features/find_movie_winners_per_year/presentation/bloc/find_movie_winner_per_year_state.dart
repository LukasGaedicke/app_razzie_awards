import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';

abstract class FindMovieWinnerPerYearState {}

class InitialFindMovieWinnerPerYearState extends FindMovieWinnerPerYearState {}

class LoadingFindMovieWinnerPerYearState extends FindMovieWinnerPerYearState {}

class LoadedFindMovieWinnerPerYearState extends FindMovieWinnerPerYearState {
  LoadedFindMovieWinnerPerYearState(this.movie);

  final Movie movie;
}

class ErrorFindMovieWinnerPerYearState extends FindMovieWinnerPerYearState {}
