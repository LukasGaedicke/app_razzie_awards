import 'dart:async';

import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';
import 'package:app_golden_raspberry_awards/shared/http_client/client.dart';

abstract class AllMoviesRemoteDatasource {
  FutureOr<MoviesPageModel> getAllMoviesWinners(int page, int limit,
      {bool? winner, int? year});
}

class AllMoviesRemoteDatasourceImpl implements AllMoviesRemoteDatasource {
  AllMoviesRemoteDatasourceImpl(this.client);

  final AppHttpClient client;

  @override
  FutureOr<MoviesPageModel> getAllMoviesWinners(int page, int limit,
      {bool? winner, int? year}) async {
    final response = await client.get<MoviesPageModel>(
      '/movies',
      queryParameters: {
        'page': page,
        'size': setSizeByContextWorkArround(year!, limit),
        if (winner != null) 'winner': winner,
        if (year != 0) 'year': year
      },
      fromJson: MoviesPageModel.fromJson,
    );

    return response.data!;
  }
}

/* 
  Isso foi necessário por conta de um problema na página de listagem de 
  filmes vencedores quando enviado via param o ano. Dependendo do size informado, 
  a API tem comportamentos diferentes. Por exemplo: Mesmo havendo filmes em 2000, passando o size como 15, a 
  API retorna vázio. Passando o size como 1, a API retorna um filme de 2000.

  Nota: Essa lógica poderia ser realizada no modelo de domínio, mas por se tratar de um problema e não uma regra
  foi decidido realizar a lógica no datasource.
*/
int setSizeByContextWorkArround(int year, int size) {
  if (year != 0) {
    return 1;
  }
  return size;
}
