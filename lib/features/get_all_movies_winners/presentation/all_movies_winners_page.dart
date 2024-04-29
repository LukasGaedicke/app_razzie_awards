import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/data/model/movies_page_model.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/domain/usecases/get_all_movies_winners_usecase.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/presentation/bloc/all_movies_winners_cubit.dart';
import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/presentation/bloc/all_movies_winners_state.dart';
import 'package:app_golden_raspberry_awards/shared/styles/metrics.dart';
import 'package:app_golden_raspberry_awards/shared/widgets/error_try_again_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';

class AllMoviesWinnersPage extends StatefulWidget {
  const AllMoviesWinnersPage({super.key});

  @override
  AllMoviesWinnersPageState createState() => AllMoviesWinnersPageState();
}

class AllMoviesWinnersPageState extends State<AllMoviesWinnersPage> {
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 1;
  bool _hasNextPage = true;
  List<Movie> _movies = [];
  // [0] - Winner filter (All, Yes, No); [1] - Year filter (0 (All) or 2023, 2024...)
  List<dynamic> _filters = [];

  final cubit =
      AllMoviesWinnersCubit(useCase: getIt<GetAllMoviesWinnersUseCase>());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  void _resetPageState() {
    _currentPage = 1;
    _hasNextPage = true;
    var auxiliary = _filters;
    _movies = [];
    _filters = [];

    cubit.getAllMoviesMostWinner(
        _currentPage, quantity_movies_get_pagginable, auxiliary);
  }

  void _refreshPageState() {
    _currentPage = 1;
    _hasNextPage = true;
    _movies = [];
    _filters = [];

    cubit.getAllMoviesMostWinner(
        _currentPage, quantity_movies_get_pagginable, ['All', 0]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        _hasNextPage) {
      _currentPage++;
      cubit.getAllMoviesMostWinner(
          _currentPage, quantity_movies_get_pagginable, _filters);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('All Time Winners')),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: false,
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(spacing * 2),
                    height: 650,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: spacing,
                        ),
                        const Text('Filter by:',
                            style: TextStyle(fontSize: 20)),
                        const SizedBox(
                          height: spacing,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Winner?',
                          ),
                          items: ['All', 'Yes', 'No']
                              .map((label) => DropdownMenuItem(
                                    value: label,
                                    child: Text(label),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _filters.insert(0, value);
                            _filters.insert(1, 0);
                          },
                        ),
                        const SizedBox(
                          height: spacing,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Year',
                          ),
                          validator: (value) {
                            return int.parse(value!) > 1980 ||
                                    int.parse(value) < 2023
                                ? 'Invalid year (1980-1980)'
                                : null;
                          },
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _filters.insert(1, int.parse(value));
                          },
                        ),
                        const SizedBox(
                          height: spacing,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cubit.setWinner(_filters);
                            Navigator.pop(context);
                          },
                          child: const Text('Apply'),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocConsumer<AllMoviesWinnersCubit, GetAllMoviesWinnersState>(
          listener: (context, state) {
            if (state is LoadedLastMovieGetAllMoviesWinnersState) {
              _hasNextPage = false;
            }

            if (state is FilterAppliedGetAllMoviesWinnersState) {
              _resetPageState();
            }

            if (state is LoadedGetAllMoviesWinnersState) {
              _movies = state.allMovies;
            }
          },
          builder: (context, state) {
            if (state is ErrorGetAllMoviesWinnersState) {
              return ErrorTryAgainPage(
                onTryAgain: _refreshPageState,
              );
            }

            if (state is NotFoundedAllMoviesWinnersState) {
              return const Center(
                child: Text('No movies found'),
              );
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return ListTile(
                    title: Text('${movie.title} (${movie.year})'),
                    trailing: Text(movie.winner ? 'Winner' : 'No Winner'),
                    subtitle: Text(
                      '${movie.producers.join(', ')} \nStudio: ${movie.studios.join(', ')}',
                    ));
              },
            );
          },
        ),
      ),
    );
  }
}
