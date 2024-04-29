import 'package:equatable/equatable.dart';

class StudioMostWinner extends Equatable {
  final String name;
  final int winCount;

  const StudioMostWinner({
    required this.name,
    required this.winCount,
  });

  @override
  List<Object?> get props => [name, winCount];
}
