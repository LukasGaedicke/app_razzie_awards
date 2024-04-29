import 'package:equatable/equatable.dart';

import '../../domains/entities/studio_most_winner.dart';

abstract class StudiosMostWinnerState extends Equatable {}

class InitialStudiosMostWinnerState extends StudiosMostWinnerState {
  @override
  List<StudioMostWinner> get props => [];
}

class LoadingStudiosMostWinnerState extends StudiosMostWinnerState {
  @override
  List<StudioMostWinner> get props => [];
}

class LoadedStudiosMostWinnerState extends StudiosMostWinnerState {
  LoadedStudiosMostWinnerState(this.studios);

  final List<StudioMostWinner> studios;

  @override
  List<StudioMostWinner> get props => studios;
}

class ErrorStudiosMostWinnerState extends StudiosMostWinnerState {
  @override
  List<StudioMostWinner> get props => [];
}
