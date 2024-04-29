import 'dart:async';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/data/models/studio_most_list_winner_model.dart';
import 'package:app_golden_raspberry_awards/shared/http_client/client.dart';

abstract class StudioMostWinnerRemoteDatasource {
  FutureOr<StudioMostWinnerListModel> getStudiosMostWinner();
}

class StudioMostWinnerRemoteDatasourceImpl
    implements StudioMostWinnerRemoteDatasource {
  StudioMostWinnerRemoteDatasourceImpl(this.client);

  final AppHttpClient client;

  @override
  FutureOr<StudioMostWinnerListModel> getStudiosMostWinner() async {
    final response = await client.get<StudioMostWinnerListModel>(
      '/movies',
      queryParameters: {
        'projection': 'studios-with-win-count',
      },
      fromJson: StudioMostWinnerListModel.fromJson,
    );

    return response.data!;
  }
}
