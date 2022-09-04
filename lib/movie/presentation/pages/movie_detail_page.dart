import 'package:flutter/material.dart';

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

    Future.microtask(() {
      // TODO
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
