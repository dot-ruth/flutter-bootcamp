import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import 'popular_movie_card.dart';

class PopularMovies extends StatelessWidget {
  final List<MovieModel> movies;

  const PopularMovies({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < movies.length) {
            final movie = movies[index];
            return PopularMovieCard(movie: movie);
          } else {
            return const SizedBox.shrink();
          }
        },
        childCount: movies.length,
      ),
    );
  }
}

