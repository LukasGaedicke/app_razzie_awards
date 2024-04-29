import 'dart:async';

import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/domains/entities/studio_most_winner.dart';

abstract class StudiosMostWinnerRepository {
  FutureOr<List<StudioMostWinner>> getStudiosMostWinner();
}
