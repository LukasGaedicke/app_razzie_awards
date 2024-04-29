import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/data/models/studio_most_winner_model.dart';

class StudioMostWinnerListModel {
  List<StudioMostWinnerModel> studiosMostWinner;

  StudioMostWinnerListModel({required this.studiosMostWinner});

  factory StudioMostWinnerListModel.fromJson(Map<String, dynamic> json) {
    return StudioMostWinnerListModel(
        studiosMostWinner: List<StudioMostWinnerModel>.from(
            json['studios'].map((x) => StudioMostWinnerModel.fromJson(x))));
  }
}
