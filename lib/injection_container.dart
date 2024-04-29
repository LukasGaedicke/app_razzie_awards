import 'dart:async';

import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/data/datasource/find_movie_winner_per_year_datasource.dart';
import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/data/repositories/find_movie_winner_per_year_repository_impl.dart';
import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/domain/repositories/find_movie_winner_per_year_repository.dart';
import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/domain/usecases/find_movie_winner_per_year_usecase.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/datasource/all_movies_winners_remote_datasource.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/repositories/all_movies_winners_repository_impl.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/domain/repositories/all_movies_winners_repository.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/domain/usecases/get_all_movies_winners_usecase.dart';
import 'package:app_golden_raspberry_awards/features/more_than_one_winner/data/datasource/movie_multiple_winner_remote_datasource.dart';
import 'package:app_golden_raspberry_awards/features/more_than_one_winner/data/repositories/movies_multiple_winner_repository_impl.dart';
import 'package:app_golden_raspberry_awards/features/more_than_one_winner/domains/repositories/movies_multiple_winner_repository.dart';
import 'package:app_golden_raspberry_awards/features/more_than_one_winner/domains/usecases/get_multiple_most_winner_usecase.dart';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/data/datasource/studio_most_winner_remote_datasource.dart';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/data/repositories/studios_most_winner_repository_impl.dart';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/domains/repositories/studios_most_winner_repository.dart';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/domains/usecases/get_studios_most_winner_usecase.dart';
import 'package:app_golden_raspberry_awards/shared/http_client/client.dart';
import 'package:app_golden_raspberry_awards/shared/http_client/options.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

FutureOr<void> init() async {
  getIt.registerLazySingleton<AppHttpClient>(() => AppHttpClientImpl(
      options: ClientOptions(
          baseUrl: 'https://tools.texoit.com/backend-java/api',
          globalTimeout: const Duration(seconds: 10)))
    ..addInterceptor());

  // ---  UseCases ---

  getIt.registerLazySingleton<GetMoviesMultipleWinnerUseCase>(
      () => GetMoviesMultipleWinnerUseCase(repository: getIt()));

  getIt.registerLazySingleton<GetAllMoviesWinnersUseCase>(
      () => GetAllMoviesWinnersUseCase(repository: getIt()));

  getIt.registerLazySingleton<GetStudiosMostWinnerUseCase>(
      () => GetStudiosMostWinnerUseCase(repository: getIt()));

  getIt.registerLazySingleton<FindMovieWinnerPerYearUseCase>(
      () => FindMovieWinnerPerYearUseCase(repository: getIt()));

  // ---  Datasources ---

  getIt.registerLazySingleton<MovieMultipleWinnerRemoteDatasource>(
      () => MovieMultipleWinnerRemoteDatasourceImpl(getIt<AppHttpClient>()));

  getIt.registerLazySingleton<StudioMostWinnerRemoteDatasource>(
      () => StudioMostWinnerRemoteDatasourceImpl(getIt<AppHttpClient>()));

  getIt.registerLazySingleton<AllMoviesRemoteDatasource>(
      () => AllMoviesRemoteDatasourceImpl(getIt<AppHttpClient>()));

  getIt.registerLazySingleton<FindMovieWinnerPerYearDatasource>(
      () => FindMovieWinnerPerYearDatasourceImpl(getIt<AppHttpClient>()));

  // --- Repositories ---

  getIt.registerLazySingleton<MoviesMultipleWinnerRepository>(() =>
      MoviesMultipleWinnerRepositoryImpl(
          getIt<MovieMultipleWinnerRemoteDatasource>()));

  getIt.registerLazySingleton<StudiosMostWinnerRepository>(() =>
      StudioMostWinnerRepositoryImpl(
          getIt<StudioMostWinnerRemoteDatasource>()));

  getIt.registerLazySingleton<AllMoviesWinnersRepository>(
      () => AllMoviesWinnersRepositoryImpl(getIt<AllMoviesRemoteDatasource>()));

  getIt.registerLazySingleton<FindMovieWinnerPerYearRepository>(() =>
      FindMovieWinnerPerYearRepositoryImpl(
          getIt<FindMovieWinnerPerYearDatasource>()));
}
