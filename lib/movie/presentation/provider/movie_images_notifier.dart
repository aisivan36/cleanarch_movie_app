import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/media_image.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_moive_images.dart';
import 'package:flutter/material.dart';

class MovieImagesNotifier extends ChangeNotifier {
  final GetMovieImages getMovieImages;

  MovieImagesNotifier({required this.getMovieImages});

  late MediaImage _movieImages;
  MediaImage get movieImages => _movieImages;

  RequestState _movieImagesState = RequestState.empty;
  RequestState get movieImagesState => _movieImagesState;

  String _message = 'null message';
  String get message => _message;

  Future<void> fetchMovieImages(int id) async {
    _movieImagesState = RequestState.loading;
    notifyListeners();

    final result = await getMovieImages.execute(id);

    result.fold((failure) {
      _movieImagesState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (movieImages) {
      _movieImagesState = RequestState.loaded;
      _movieImages = movieImages;
      notifyListeners();
    });
  }
}
