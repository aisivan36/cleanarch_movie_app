import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:cleanarch_movie_app/seach/domain/usecases/search_movies.dart';
import 'package:cleanarch_movie_app/seach/domain/usecases/search_tvs.dart';
import 'package:cleanarch_movie_app/tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class MovieSearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchMovies.execute(query: query);

        result.fold(
          (failure) => emit(SearchError(message: failure.message)),
          (data) => emit(
            MovieSearchHasData(result: data),
          ),
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}

class TvSearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTvs _searchTvs;

  TvSearchBloc(this._searchTvs) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchTvs.execute(query: query);

        result.fold(
          (failure) => emit(SearchError(message: failure.message)),
          (data) => emit(
            TvSearchHasData(result: data),
          ),
        );
      },
      transformer: debounce(
        const Duration(microseconds: 500),
      ),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  // return (events, mapper) => events.d
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
