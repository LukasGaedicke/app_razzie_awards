import 'package:app_golden_raspberry_awards/config/routes/app_route.dart';
import 'package:app_golden_raspberry_awards/shared/styles/metrics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeMultipleListPage extends StatelessWidget {
  const HomeMultipleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(spacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Select bellows options to see the best movies and studios of the Golden Raspberry Awards',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: spacing * 3),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.studiosMostWinner.path),
              child: const Text('See top 3 studios with the most wins',
                  style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: spacing),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.moviesMultipleWinner.path),
              child: const Text('See years with multiple wins',
                  style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: spacing),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.findPerYear.path),
              child: const Text('Find movie winner per year',
                  style: TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
