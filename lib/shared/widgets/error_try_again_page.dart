import 'package:flutter/material.dart';

class ErrorTryAgainPage extends StatelessWidget {
  final VoidCallback onTryAgain;

  const ErrorTryAgainPage({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Oops, something went wrong!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => onTryAgain(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
