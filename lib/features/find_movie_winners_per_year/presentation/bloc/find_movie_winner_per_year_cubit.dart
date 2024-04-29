import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/domain/usecases/find_movie_winner_per_year_usecase.dart';
import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/presentation/bloc/find_movie_winner_per_year_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindMovieWinnerPerYearCubit extends Cubit<FindMovieWinnerPerYearState> {
  final FindMovieWinnerPerYearUseCase useCase;

  FindMovieWinnerPerYearCubit({required this.useCase})
      : super(InitialFindMovieWinnerPerYearState());

  findMovieWinnerPerYear(int year) async {
    try {
      emit(LoadingFindMovieWinnerPerYearState());
      final movies = await useCase.execute(year);
      emit(LoadedFindMovieWinnerPerYearState(movies));
    } catch (e) {
      emit(ErrorFindMovieWinnerPerYearState());
    }
  }
}
