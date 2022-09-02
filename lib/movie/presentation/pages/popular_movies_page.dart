import 'package:cleanarch_movie_app/movie/presentation/provider/popular_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatefulWidget {
  static const String routeName = '/popular-movies';

  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<PopularMoviesNotifier>(context, listen: false)
          .fetchPopularMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
