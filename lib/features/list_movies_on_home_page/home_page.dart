import 'package:app_golden_raspberry_awards/features/get_all_movies_winners/presentation/all_movies_winners_page.dart';
import 'package:app_golden_raspberry_awards/features/list_movies_on_home_page/home_multiple_list_page.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeMultipleListPage(),
    const AllMoviesWinnersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text('Golden Raspberry Awards'),
      )),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'All Movies Winners',
          ),
        ],
      ),
    );
  }
}
