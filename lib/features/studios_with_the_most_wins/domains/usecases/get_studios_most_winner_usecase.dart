import 'dart:async';

import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/domains/repositories/studios_most_winner_repository.dart';

import '../entities/studio_most_winner.dart';

class GetStudiosMostWinnerUseCase {
  late final StudiosMostWinnerRepository repository;

  GetStudiosMostWinnerUseCase({required this.repository});

  FutureOr<List<StudioMostWinner>> execute() async {
    final studios = await repository.getStudiosMostWinner();
    return studios.take(3).toList();
  }
}
