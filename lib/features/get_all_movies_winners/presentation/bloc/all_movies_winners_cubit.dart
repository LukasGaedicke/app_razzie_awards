import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/domain/usecases/get_all_movies_winners_usecase.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/presentation/bloc/all_movies_winners_state.dart';
import 'package:app_golden_raspberry_awards/shared/styles/metrics.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AllMoviesWinnersCubit extends Cubit<GetAllMoviesWinnersState> {
  final GetAllMoviesWinnersUseCase useCase;

  final List<Movie> _moviesLoaded = [];
  List<dynamic> cubitFiltersSelected = [];

  AllMoviesWinnersCubit({required this.useCase})
      : super(InitialGetAllMoviesWinnersState()) {
    getAllMoviesMostWinner(1, quantity_movies_get_pagginable, ['All', 0]);
  }

  void setWinner(List<dynamic> filterSelected) {
    _moviesLoaded.clear();
    cubitFiltersSelected = filterSelected;
    emit(FilterAppliedGetAllMoviesWinnersState());
  }

  getAllMoviesMostWinner(
      int page, int limit, List<dynamic> filtersSelected) async {
    try {
      emit(LoadingGetAllMoviesWinnersState());

      String winnerFilterSelected =
          (cubitFiltersSelected.isNotEmpty) ? cubitFiltersSelected[0] : 'All';

      int yearFilterSelected =
          (cubitFiltersSelected.isNotEmpty) ? cubitFiltersSelected[1] : 0;

      List<Movie> remoteMoviesList = await useCase
          .execute(page, limit, [winnerFilterSelected, yearFilterSelected]);

      if (remoteMoviesList.isEmpty) {
        if (_moviesLoaded.isNotEmpty) {
          emit(LoadedLastMovieGetAllMoviesWinnersState());
          return;
        } else {
          emit(NotFoundedAllMoviesWinnersState());
          return;
        }
      }

      _moviesLoaded.addAll(remoteMoviesList);

      emit(LoadedGetAllMoviesWinnersState(_moviesLoaded));
    } catch (e) {
      emit(ErrorGetAllMoviesWinnersState());
    }
  }
}
