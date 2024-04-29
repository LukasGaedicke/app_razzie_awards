import 'dart:async';

import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/domains/entities/studio_most_winner.dart';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/domains/repositories/studios_most_winner_repository.dart';

import '../datasource/studio_most_winner_remote_datasource.dart';

class StudioMostWinnerRepositoryImpl extends StudiosMostWinnerRepository {
  StudioMostWinnerRepositoryImpl(this.remoteDatasource);

  final StudioMostWinnerRemoteDatasource remoteDatasource;

  @override
  FutureOr<List<StudioMostWinner>> getStudiosMostWinner() async {
    final studiosMostWinnerListModel =
        await remoteDatasource.getStudiosMostWinner();

    List<StudioMostWinner> newList = studiosMostWinnerListModel
        .studiosMostWinner
        .map((e) => StudioMostWinner(name: e.name, winCount: e.winCount))
        .toList();

    return newList;
  }
}
