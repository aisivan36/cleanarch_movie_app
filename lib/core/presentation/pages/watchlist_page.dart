import 'package:cleanarch_movie_app/core/utils/utils.dart';
import 'package:cleanarch_movie_app/movie/presentation/pages/movie_watchlist_page.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/pages/tv_watchlist_page.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/watchlist_tv_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const String routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvNotifier>(context, listen: false)
          .fetchWatchlistTvs();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPop() {
    super.didPop();
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false)
        .fetchWatchlistTvs();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
            tabs: [
              Tab(
                key: Key('movieWatchlistTab'),
                text: 'Move',
              ),
              Tab(
                key: Key('tvWatchlistTab'),
                text: 'Tv',
              ),
            ],
            indicatorColor: Colors.redAccent,
            indicatorWeight: 4.0,
          ),
        ),
        body: const TabBarView(
          children: [
            MovieWatchlist(),
            TvWatchlist(),
          ],
        ),
      ),
    );
  }
}
