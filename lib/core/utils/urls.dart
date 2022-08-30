class Urls {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';

  /// Movies
  static const String nowPlayingMovies = '$baseUrl/movie/now_playing?$apiKey';
  static const String popularMovies = '$baseUrl/movie/popular?$apiKey';
  static const String topRatedMovies = '$baseUrl/movie/top_rated?$apiKey';
  static String movieDetail(int id) => '$baseUrl/movie/$id?$apiKey';
  static String movieRecommendations(int id) =>
      '$baseUrl/movie/$id/recommendations?$apiKey';
  static String searchMovies(String query) =>
      '$baseUrl/search/movie?$apiKey&query=$query';

  ///  Tvs
  static const String onTheAirTvs = '$baseUrl/tv/on_the_air?$apiKey';
  static const String popularTvs = '$baseUrl/tv/popular?$apiKey';
  static const String topRatedTvs = '$baseUrl/tv/top_rated?$apiKey';
  static String tvDetail(int id) => '$baseUrl/tv/$id?$apiKey';
  static String tvSeasons(int id, int seasonNumber) =>
      '$baseUrl/tv/$id/season/$seasonNumber?$apiKey';
  static String tvRecommendations(int id) =>
      '$baseUrl/tv/$id/recommendations?$apiKey';
  static String searchTvs(String query) =>
      '$baseUrl/search/tv?$apiKey&query=$query';

  /// Images
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static String imageUrl(String path) => '$baseImageUrl$path';
  static String movieImages(int id) =>
      '$baseUrl/movie/$id/images?$apiKey&language=en-US&include_image_language=en,null';
  static String tvImages(int id) =>
      '$baseUrl/tv/$id/images?$apiKey&language=en-US&include_image_language=en,null';
}
