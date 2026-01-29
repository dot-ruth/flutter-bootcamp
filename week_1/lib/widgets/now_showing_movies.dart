import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import 'now_showing_movie_card.dart';

class NowShowingMovies extends StatelessWidget {
  final ScrollController scrollController;
  final List<MovieModel> movies;

  const NowShowingMovies({
    super.key,
    required this.scrollController,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return NowShowingMovieCard(movie: movie);
        },
      ),
    );
  }
}

