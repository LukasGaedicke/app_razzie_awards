import 'package:app_golden_raspberry_awards/features/find_movie_winners_per_year/presentation/find_movie_winner_per_year_page.dart';
import 'package:app_golden_raspberry_awards/features/list_movies_on_home_page/home_page.dart';
import 'package:app_golden_raspberry_awards/features/more_than_one_winner/presentation/movie_multiple_winner_page.dart';
import 'package:app_golden_raspberry_awards/features/studios_with_the_most_wins/presentation/studio_most_winner_page.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  home('/'),
  moviesMultipleWinner('/app/movies/multiple-winner'),
  findPerYear('/app/movies/find-per-year'),
  studiosMostWinner('/app/studios/most-winner');

  const AppRoutes(this.path);

  final String path;
}

class AppRouter {
  AppRouter();

  GoRouter? _routerConfig;

  GoRouter get routerConfig => _routerConfig ??= GoRouter(
        initialLocation: AppRoutes.home.path,
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.home.path,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: AppRoutes.studiosMostWinner.path,
            builder: (context, state) => StudioMostWinnerPage(),
          ),
          GoRoute(
            path: AppRoutes.findPerYear.path,
            builder: (context, state) => FindPerYearPage(),
          ),
          GoRoute(
            path: AppRoutes.moviesMultipleWinner.path,
            builder: (context, state) => const MovieMultipleWinnerPage(),
          ),
        ],
      );

  void pop<T>(T? result) => routerConfig.pop<T>(result);

  Route? get current {
    Route? current;
    _routerConfig!.routerDelegate.navigatorKey.currentState!.popUntil((route) {
      if (route.settings.name != null) {
        current = route;
        return true;
      }
      return false;
    });
    return current;
  }
}
