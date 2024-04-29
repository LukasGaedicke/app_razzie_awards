import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/datasource/all_movies_winners_remote_datasource.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';
import 'package:app_golden_raspberry_awards/shared/http_client/client.dart';
import 'package:app_golden_raspberry_awards/shared/http_client/options.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart' as external_dio;

import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  const baseUrl = 'https://tools.texoit.com/backend-java/api';

  final mockDio = MockHttpClient();
  final httpClient = AppHttpClientImpl(
    options: ClientOptions(
      baseUrl: baseUrl,
      globalTimeout: const Duration(seconds: 10),
    ),
    dio: mockDio,
  );

  final datasource = AllMoviesRemoteDatasourceImpl(httpClient);

  group("getAllMovies", () {
    test(
      'should return a list of five movies when the response code is 200 and without filter winner and get first page',
      () async {
        final responseDio = external_dio.Response<String>(
          requestOptions: external_dio.RequestOptions(
            path: '/movies',
            baseUrl: baseUrl,
          ),
          data: loadFixtureAsString('list_five_movies_pagination.json'),
          statusCode: 200,
          statusMessage: 'OK',
        );

        when(
          () => mockDio.get<String>(
            any(),
            queryParameters: {
              'page': 1,
              'size': 5,
            },
          ),
        ).thenAnswer((_) => Future.value(responseDio));

        MoviesPageModel remote = await datasource.getAllMoviesWinners(1, 5);

        expect(remote.toJson(),
            loadFixtureFromJsonFile('list_five_movies_pagination.json'));
      },
    );

    test(
      'should return a list of 20 movies not winners when the response code is 200 and find winners is false and page is 1',
      () async {
        final responseDio = external_dio.Response<String>(
          requestOptions: external_dio.RequestOptions(
            path: '/movies',
            baseUrl: baseUrl,
          ),
          data: loadFixtureAsString('list_twenty_movies_no_winners.json'),
          statusCode: 200,
          statusMessage: 'OK',
        );

        when(
          () => mockDio.get<String>(
            any(),
            queryParameters: {
              'page': 1,
              'size': 20,
              'winner': false,
            },
          ),
        ).thenAnswer((_) => Future.value(responseDio));

        MoviesPageModel remote =
            await datasource.getAllMoviesWinners(1, 20, winner: false);

        expect(remote.toJson(),
            loadFixtureFromJsonFile('list_twenty_movies_no_winners.json'));
      },
    );

    test(
      'should return a list of 10 movies winners when the response code is 200 and find winners is true and page is 2',
      () async {
        final responseDio = external_dio.Response<String>(
          requestOptions: external_dio.RequestOptions(
            path: '/movies',
            baseUrl: baseUrl,
          ),
          data: loadFixtureAsString('list_ten_movies_winner.json'),
          statusCode: 200,
          statusMessage: 'OK',
        );

        when(
          () => mockDio.get<String>(
            any(),
            queryParameters: {
              'page': 2,
              'size': 10,
              'winner': false,
            },
          ),
        ).thenAnswer((_) => Future.value(responseDio));

        MoviesPageModel remote =
            await datasource.getAllMoviesWinners(2, 10, winner: false);

        expect(remote.toJson(),
            loadFixtureFromJsonFile('list_ten_movies_winner.json'));
      },
    );
  });
}
