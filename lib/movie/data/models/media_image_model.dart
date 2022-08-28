import 'package:cleanarch_movie_app/movie/domain/entities/media_image.dart';
import 'package:equatable/equatable.dart';

class MediaImageModel extends Equatable {
  final int id;
  final List<String> backdropPaths;
  final List<String> logoPaths;
  final List<String> posterPaths;

  const MediaImageModel({
    required this.id,
    required this.backdropPaths,
    required this.logoPaths,
    required this.posterPaths,
  });

  factory MediaImageModel.fromJson(Map<String, dynamic> json) =>
      MediaImageModel(
        id: json['id'],
        backdropPaths: List<String>.from(
            json['backdrops'].map((data) => data['file_path'])),
        logoPaths:
            List<String>.from(json['logos'].map((data) => data['file_path'])),
        posterPaths:
            List<String>.from(json['posters'].map((data) => data['file_path'])),
      );

  MediaImage toEntity() => MediaImage(
        id: id,
        backdropPaths: backdropPaths,
        logoPaths: logoPaths,
        posterPaths: posterPaths,
      );

  @override
  List<Object?> get props => [
        id,
        backdropPaths,
        logoPaths,
        posterPaths,
      ];
}
