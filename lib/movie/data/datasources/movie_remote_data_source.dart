import 'dart:convert';
import 'package:cleanarch_movie_app/core/utils/exception.dart';
import 'package:cleanarch_movie_app/core/utils/urls.dart';
import 'package:cleanarch_movie_app/movie/data/models/media_image_model.dart';
import 'package:cleanarch_movie_app/movie/data/models/movie_detail_response.dart';
import 'package:cleanarch_movie_app/movie/data/models/movie_model.dart';
import 'package:cleanarch_movie_app/movie/data/models/movie_response.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
  Future<MediaImageModel> getMovieImages(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final respone = await client.get(Uri.parse(Urls.nowPlayingMovies));

    if (respone.statusCode == 200) {
      return MovieRespone.fromJson(json.decode(respone.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(Uri.parse(Urls.popularMovies));

    if (response.statusCode == 200) {
      return MovieRespone.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await client.get(Uri.parse(Urls.topRatedMovies));

    if (response.statusCode == 200) {
      return MovieRespone.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response = await client.get(Uri.parse(Urls.movieDetail(id)));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decoder.convert(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client.get(Uri.parse(Urls.movieRecommendations(id)));

    if (response.statusCode == 200) {
      return MovieRespone.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get(Uri.parse(Urls.searchMovies(query)));

    if (response.statusCode == 200) {
      return MovieRespone.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MediaImageModel> getMovieImages(int id) async {
    final response = await client.get(Uri.parse(Urls.movieImages(id)));

    if (response.statusCode == 200) {
      return MediaImageModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
