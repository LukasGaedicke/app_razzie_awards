import 'package:app_golden_raspberry_awards/config/routes/app_route.dart';
import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/domain/usecases/find_movie_winner_per_year_usecase.dart';
import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/presentation/bloc/find_movie_winner_per_year_cubit.dart';
import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/presentation/bloc/find_movie_winner_per_year_state.dart';
import 'package:app_golden_raspberry_awards/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FindPerYearPage extends StatelessWidget {
  FindPerYearPage({Key? key}) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Winner per Year'),
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
        create: (context) => FindMovieWinnerPerYearCubit(
            useCase: getIt<FindMovieWinnerPerYearUseCase>()),
        child: BlocBuilder<FindMovieWinnerPerYearCubit,
            FindMovieWinnerPerYearState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        labelText: 'Year',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a year';
                        }
                        if (int.parse(value) < 1980 ||
                            int.parse(value) > 2023) {
                          return 'Please enter a year between 1980 and 2023';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        _submit(
                            context,
                            context.read<FindMovieWinnerPerYearCubit>(),
                            int.parse(_textEditingController.text),
                            _formKey);
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submit(
                          context,
                          context.read<FindMovieWinnerPerYearCubit>(),
                          int.parse(_textEditingController.text),
                          _formKey);
                    },
                    child: const Text('Find Winner'),
                  ),
                  Expanded(
                    child: _buildBody(state),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void _submit(BuildContext context, FindMovieWinnerPerYearCubit cubit, int year,
    GlobalKey<FormState> formKey) {
  if (formKey.currentState!.validate()) {
    cubit.findMovieWinnerPerYear(year);
  }
}

Widget _buildBody(FindMovieWinnerPerYearState state) {
  if (state is InitialFindMovieWinnerPerYearState) {
    return const Center(
      child: Text('Enter a year to find the winner'),
    );
  } else if (state is LoadingFindMovieWinnerPerYearState) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  } else if (state is LoadedFindMovieWinnerPerYearState) {
    return ListTile(
        title: Text('${state.movie.title} (${state.movie.year})'),
        subtitle: Text(
          '${state.movie.producers.join(', ')} \nStudio: ${state.movie.studios.join(', ')}',
        ));
  } else {
    return const Center(
      child: Text('Error finding the winner. Try again.'),
    );
  }
}
