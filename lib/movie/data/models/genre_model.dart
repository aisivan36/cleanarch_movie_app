import 'package:cleanarch_movie_app/movie/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  final int id;
  final String name;

  const GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> tojson() => {
        'id': id,
        'name': name,
      };

  Genre toEntity() => Genre(id: id, name: name);

  @override
  List<Object?> get props => [id, name];
}
