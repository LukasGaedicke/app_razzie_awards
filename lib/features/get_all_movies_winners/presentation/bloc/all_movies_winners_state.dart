import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetAllMoviesWinnersState extends Equatable {}

class InitialGetAllMoviesWinnersState extends GetAllMoviesWinnersState {
  @override
  List<Movie> get props => [];
}

class LoadingGetAllMoviesWinnersState extends GetAllMoviesWinnersState {
  @override
  List<Movie> get props => [];
}

class LoadedGetAllMoviesWinnersState extends GetAllMoviesWinnersState {
  LoadedGetAllMoviesWinnersState(this.allMovies);

  final List<Movie> allMovies;

  @override
  List<Movie> get props => allMovies;
}

class LoadedLastMovieGetAllMoviesWinnersState extends GetAllMoviesWinnersState {
  LoadedLastMovieGetAllMoviesWinnersState();

  @override
  List<Movie> get props => [];
}

class ErrorGetAllMoviesWinnersState extends GetAllMoviesWinnersState {
  @override
  List<Movie> get props => [];
}

class FilterAppliedGetAllMoviesWinnersState extends GetAllMoviesWinnersState {
  @override
  List<Movie> get props => [];
}

class NotFoundedAllMoviesWinnersState extends GetAllMoviesWinnersState {
  @override
  List<Movie> get props => [];
}
