import 'package:equatable/equatable.dart';

class MovieMultipleWinner extends Equatable {
  final int year;
  final int winnerCount;

  const MovieMultipleWinner({
    required this.year,
    required this.winnerCount,
  });

  @override
  List<Object?> get props => [year, winnerCount];
}
