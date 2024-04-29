import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/domains/entities/studio_most_winner.dart';

class StudioMostWinnerModel extends StudioMostWinner {
  const StudioMostWinnerModel({required super.name, required super.winCount});

  factory StudioMostWinnerModel.fromJson(Map<String, dynamic> json) {
    return StudioMostWinnerModel(
      name: json['name'],
      winCount: json['winCount'],
    );
  }
}
