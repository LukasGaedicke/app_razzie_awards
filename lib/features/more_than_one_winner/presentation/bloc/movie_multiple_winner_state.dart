import 'package:equatable/equatable.dart';

import '../../domains/entities/movie_multiple_winner.dart';

abstract class MovieMultipleWinnerState extends Equatable {}

class InitialMovieMultipleWinnerState extends MovieMultipleWinnerState {
  @override
  List<MovieMultipleWinner> get props => [];
}

class LoadingMovieMultipleWinnerState extends MovieMultipleWinnerState {
  @override
  List<MovieMultipleWinner> get props => [];
}

class LoadedMovieMultipleWinnerState extends MovieMultipleWinnerState {
  LoadedMovieMultipleWinnerState(this.movies);

  final List<MovieMultipleWinner> movies;

  @override
  List<MovieMultipleWinner> get props => movies;
}

class ErrorMovieMultipleWinnerState extends MovieMultipleWinnerState {
  @override
  List<MovieMultipleWinner> get props => [];
}
