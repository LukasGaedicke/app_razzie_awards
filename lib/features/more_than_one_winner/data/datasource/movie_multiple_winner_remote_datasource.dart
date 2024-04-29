import 'dart:async';

import 'package:app_golden_raspberry_awards/shared/http_client/client.dart';
import 'package:app_golden_raspberry_awards/features/more_than_one_winner/data/models/movie_multiple_list_winner_model.dart';

abstract class MovieMultipleWinnerRemoteDatasource {
  FutureOr<MovieMultipleWinnerListModel> getMoviesMultipleWinner();
}

class MovieMultipleWinnerRemoteDatasourceImpl
    implements MovieMultipleWinnerRemoteDatasource {
  MovieMultipleWinnerRemoteDatasourceImpl(this.client);

  final AppHttpClient client;

  @override
  FutureOr<MovieMultipleWinnerListModel> getMoviesMultipleWinner() async {
    final response = await client.get<MovieMultipleWinnerListModel>(
      '/movies',
      queryParameters: {
        'projection': 'years-with-multiple-winners',
      },
      fromJson: MovieMultipleWinnerListModel.fromJson,
    );

    return response.data!;
  }
}
