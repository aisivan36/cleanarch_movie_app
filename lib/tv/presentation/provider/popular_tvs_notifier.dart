import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_popular_tvs.dart';

class PopularTvsNotifier extends ChangeNotifier {
  final GetPopularTvs getPopularTvs;

  PopularTvsNotifier(this.getPopularTvs);

  List<Tv> _tvs = <Tv>[];
  List<Tv> get tvs => _tvs;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _state = RequestState.loaded;
        _tvs = tvsData;
        notifyListeners();
      },
    );
  }
}
