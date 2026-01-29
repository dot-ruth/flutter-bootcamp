class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final List<String> genres;

  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
  });
}

/// Dummy movies used for Week 1 (static UI only).
final List<MovieModel> dummyNowShowingMovies = [
  MovieModel(
    id: 1,
    title: 'The Space Odyssey',
    overview:
        'A visually stunning journey through space as a crew embarks on a mission beyond the solar system.',
    posterPath: 'assets/images/movies/movie.jpeg',
    backdropPath: 'assets/images/movies/drawer.png',
    voteAverage: 8.7,
    releaseDate: '2024-01-15',
    genres: ['Sci-Fi', 'Adventure'],
  ),
  MovieModel(
    id: 2,
    title: 'City Lights',
    overview:
        'A heartfelt drama about love, loss, and second chances in a bustling modern city.',
    posterPath: 'assets/images/movies/movie.jpeg',
    backdropPath: 'assets/images/movies/drawer.png',
    voteAverage: 7.9,
    releaseDate: '2023-10-03',
    genres: ['Drama', 'Romance'],
  ),
];

final List<MovieModel> dummyPopularMovies = [
  MovieModel(
    id: 3,
    title: 'Hidden Shadows',
    overview:
        'A detective unravels a web of secrets that threaten to upend an entire city.',
    posterPath: 'assets/images/movies/movie.jpeg',
    backdropPath: 'assets/images/movies/drawer.png',
    voteAverage: 8.2,
    releaseDate: '2023-05-21',
    genres: ['Thriller', 'Crime'],
  ),
  MovieModel(
    id: 4,
    title: 'Dreamscape',
    overview:
        'A group of friends discovers they can enter each other’s dreams with unexpected consequences.',
    posterPath: 'assets/images/movies/movie.jpeg',
    backdropPath: 'assets/images/movies/drawer.png',
    voteAverage: 8.5,
    releaseDate: '2022-11-11',
    genres: ['Fantasy', 'Mystery'],
  ),
];

