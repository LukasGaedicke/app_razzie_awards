import '../../domains/usecases/get_studios_most_winner_usecase.dart';
import 'studios_most_winner_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudioMostWinnerCubit extends Cubit<StudiosMostWinnerState> {
  final GetStudiosMostWinnerUseCase useCase;

  StudioMostWinnerCubit({required this.useCase})
      : super(InitialStudiosMostWinnerState()) {
    getStudiosMostWinner();
  }

  getStudiosMostWinner() async {
    try {
      emit(LoadingStudiosMostWinnerState());
      final movies = await useCase.execute();
      emit(LoadedStudiosMostWinnerState(movies));
    } catch (e) {
      emit(ErrorStudiosMostWinnerState());
    }
  }
}
