import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MinimalDetail extends StatelessWidget {
  final String? keyValue;
  final String? closeKeyValue;
  final Movie movie;

  const MinimalDetail({
    Key? key,
    required this.movie,
    this.closeKeyValue,
    this.keyValue,
  }) : super(key: key);

  @override
  // TODO Have to write this up
  Widget build(BuildContext context) => SizedBox(
        height: 300.0,
        child: Column(
          children: [Text(' For Testing you know')],
        ),
      );
}
