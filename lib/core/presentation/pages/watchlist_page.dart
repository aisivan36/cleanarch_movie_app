import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const String routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      /// TODO THIS HERE in the microtask
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
