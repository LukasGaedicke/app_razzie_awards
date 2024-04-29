import 'dart:async';

import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/data/model/movies_model.dart';
import 'package:app_golden_raspberry_awards/shared/http_client/client.dart';

abstract class FindMovieWinnerPerYearDatasource {
  Future<MovieModel> getMovieWinnerPerYear(int year);
}

class FindMovieWinnerPerYearDatasourceImpl
    implements FindMovieWinnerPerYearDatasource {
  FindMovieWinnerPerYearDatasourceImpl(this.client);

  final AppHttpClient client;

  @override
  Future<MovieModel> getMovieWinnerPerYear(int year) async {
    final response = await client.getAsList<MovieModel>(
      '/movies',
      queryParameters: {'year': year, 'winner': true},
      fromJson: MovieModel.fromJson,
    );

    return response.data!.first;
  }
}
