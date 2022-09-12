import 'package:animate_do/animate_do.dart';
import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/popular_movies_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/widgets/item_card_list.dart';
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Popular Movies'),
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularMoviesNotifier>(
          builder: (context, value, child) {
            if (value.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.state == RequestState.loaded) {
              return FadeInUp(
                from: 20,
                child: ListView.builder(
                  key: const Key('popularMoviesListView'),
                  itemCount: value.movies.length,
                  itemBuilder: (context, index) {
                    final movie = value.movies[index];
                    return ItemCard(movie: movie);
                  },
                ),
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(value.message),
              );
            }
          },
        ),
      ),
    );
  }
}
