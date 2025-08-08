import 'package:json_annotation/json_annotation.dart';
import 'package:movie/models/actor.dart';

part 'movie_details.g.dart';

@JsonSerializable()
class MovieDetails {
  final int id;
  final String title;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final int? runtime;
  final List<Genre> genres;
  @JsonKey(name: 'credits')
  final Credits? credits;

  const MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    this.runtime,
    required this.genres,
    this.credits,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => _$MovieDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  String get posterUrl {
    if (posterPath == null) return '';
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String get backdropUrl {
    if (backdropPath == null) return '';
    return 'https://image.tmdb.org/t/p/original$backdropPath';
  }

  String get releaseYear {
    if (releaseDate == null || releaseDate!.isEmpty) return '';
    return releaseDate!.split('-')[0];
  }

  List<Actor> get cast {
    return credits?.cast ?? [];
  }

  List<Actor> get crew {
    return credits?.crew ?? [];
  }
}

@JsonSerializable()
class Genre {
  final int id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

@JsonSerializable()
class Credits {
  final List<Actor> cast;
  final List<Actor> crew;

  const Credits({
    required this.cast,
    required this.crew,
  });

  factory Credits.fromJson(Map<String, dynamic> json) => _$CreditsFromJson(json);
  Map<String, dynamic> toJson() => _$CreditsToJson(this);
}
