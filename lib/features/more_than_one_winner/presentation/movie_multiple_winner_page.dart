import 'package:app_golden_raspberry_awards/config/routes/app_route.dart';
import 'package:app_golden_raspberry_awards/features/more_than_one_winner/domains/usecases/get_multiple_most_winner_usecase.dart';
import 'package:app_golden_raspberry_awards/features/more_than_one_winner/presentation/bloc/movie_multiple_winner_cubit.dart';
import 'package:app_golden_raspberry_awards/features/more_than_one_winner/presentation/bloc/movie_multiple_winner_state.dart';
import 'package:app_golden_raspberry_awards/injection_container.dart';
import 'package:app_golden_raspberry_awards/shared/widgets/error_try_again_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MovieMultipleWinnerPage extends StatefulWidget {
  const MovieMultipleWinnerPage({Key? key}) : super(key: key);

  @override
  State<MovieMultipleWinnerPage> createState() =>
      _MovieMultipleWinnerPageState();
}

class _MovieMultipleWinnerPageState extends State<MovieMultipleWinnerPage> {
  final cubit = MovieMultipleWinnerCubit(
      useCase: getIt<GetMoviesMultipleWinnerUseCase>());

  void _tryAgain() {
    cubit.getMoviesMultipleWinner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Years with multi wins'),
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
        create: (context) => MovieMultipleWinnerCubit(
            useCase: getIt<GetMoviesMultipleWinnerUseCase>()),
        child: BlocBuilder<MovieMultipleWinnerCubit, MovieMultipleWinnerState>(
          builder: (context, state) {
            if (state is LoadingMovieMultipleWinnerState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedMovieMultipleWinnerState) {
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return ListTile(
                    title: Text("Year: ${movie.year}"),
                    subtitle: Text(movie.winnerCount.toString()),
                  );
                },
              );
            } else if (state is ErrorMovieMultipleWinnerState) {
              return ErrorTryAgainPage(
                onTryAgain: _tryAgain,
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
