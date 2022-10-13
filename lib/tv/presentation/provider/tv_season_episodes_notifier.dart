import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_season_episode.dart';
import '../../domain/usecases/get_tv_season_episodes.dart';

class TvSeasonEpisodesNotifier extends ChangeNotifier {
  final GetTvSeasonEpisodes getTvSeasonEpisodes;

  TvSeasonEpisodesNotifier({required this.getTvSeasonEpisodes});

  late List<TvSeasonEpisode> _seasonEpisodes;
  List<TvSeasonEpisode> get seasonEpisodes => _seasonEpisodes;

  RequestState _seasonEpisodesState = RequestState.empty;
  RequestState get seasonEpisodesState => _seasonEpisodesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasonEpisodes(int id, int seasonNumber) async {
    _seasonEpisodesState = RequestState.loading;
    notifyListeners();

    final seasonEpisodesResult =
        await getTvSeasonEpisodes.execute(id, seasonNumber);

    seasonEpisodesResult.fold(
      (failure) {
        _seasonEpisodesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (seasonEpisode) {
        _seasonEpisodesState = RequestState.loaded;
        _seasonEpisodes = seasonEpisode;
        notifyListeners();
      },
    );
  }
}
