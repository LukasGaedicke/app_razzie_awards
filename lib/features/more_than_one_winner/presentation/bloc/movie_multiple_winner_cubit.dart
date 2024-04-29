import '../../domains/usecases/get_multiple_most_winner_usecase.dart';
import 'movie_multiple_winner_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieMultipleWinnerCubit extends Cubit<MovieMultipleWinnerState> {
  final GetMoviesMultipleWinnerUseCase useCase;

  MovieMultipleWinnerCubit({required this.useCase})
      : super(InitialMovieMultipleWinnerState()) {
    getMoviesMultipleWinner();
  }

  getMoviesMultipleWinner() async {
    try {
      emit(LoadingMovieMultipleWinnerState());
      final movies = await useCase.execute();
      emit(LoadedMovieMultipleWinnerState(movies));
    } catch (e) {
      emit(ErrorMovieMultipleWinnerState());
    }
  }
}
