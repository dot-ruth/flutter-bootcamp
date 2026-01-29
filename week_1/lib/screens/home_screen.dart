import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../widgets/now_showing_movies.dart';
import '../widgets/popular_movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController nowShowingControl = ScrollController();
  final ScrollController popularControl = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmku'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        controller: popularControl,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  child: Text(
                    'Now Showing',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                NowShowingMovies(
                  scrollController: nowShowingControl,
                  movies: dummyNowShowingMovies,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  child: Text(
                    'Popular',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          PopularMovies(
            movies: dummyPopularMovies,
          ),
        ],
      ),
    );
  }
}

