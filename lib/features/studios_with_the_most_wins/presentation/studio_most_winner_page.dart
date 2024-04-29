import 'package:app_golden_raspberry_awards/config/routes/app_route.dart';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/domains/usecases/get_studios_most_winner_usecase.dart';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/presentation/bloc/studios_most_winner_cubit.dart';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/presentation/bloc/studios_most_winner_state.dart';
import 'package:app_golden_raspberry_awards/injection_container.dart';
import 'package:app_golden_raspberry_awards/shared/widgets/error_try_again_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StudioMostWinnerPage extends StatelessWidget {
  StudioMostWinnerPage({Key? key}) : super(key: key);

  final cubit =
      StudioMostWinnerCubit(useCase: getIt<GetStudiosMostWinnerUseCase>());

  void tryAgain() {
    cubit.getStudiosMostWinner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Top 3 studios wins'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.home.path);
              }
            },
          )),
      body: BlocProvider(
        create: (context) => StudioMostWinnerCubit(
            useCase: getIt<GetStudiosMostWinnerUseCase>()),
        child: BlocBuilder<StudioMostWinnerCubit, StudiosMostWinnerState>(
          builder: (context, state) {
            if (state is LoadingStudiosMostWinnerState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedStudiosMostWinnerState) {
              return ListView.builder(
                itemCount: state.studios.length,
                itemBuilder: (context, index) {
                  final movie = state.studios[index];
                  return ListTile(
                    title: Text(movie.name),
                    subtitle: Text(movie.winCount.toString()),
                  );
                },
              );
            } else if (state is ErrorStudiosMostWinnerState) {
              return ErrorTryAgainPage(
                onTryAgain: tryAgain,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
