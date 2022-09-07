import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie_detail.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const String routeName = '/movie-detail';

  final int id;

  const MovieDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () {
        Provider.of<MovieDetailNotifier>(context, listen: false)
            .fetchMovieDetail(widget.id);
        Provider.of<MovieDetailNotifier>(context, listen: false)
            .loadWatchlistStatus(widget.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, value, child) {
          if (value.movieState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.movieState == RequestState.loaded) {
            final movie = value.movie;
            return MovieDetailContent(
              movie: movie,
              recommendations: value.recommendations,
              isAddedToWatchlist: value.isAddedToWatchlist,
            );
          } else {
            return Text(value.message);
          }
        },
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedToWatchlist;

  const MovieDetailContent({
    super.key,
    required this.movie,
    required this.isAddedToWatchlist,
    required this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
