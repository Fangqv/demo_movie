import 'package:json_annotation/json_annotation.dart';

part 'actor.g.dart';

@JsonSerializable()
class Actor {
  final int id;
  final String name;
  final String? biography;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @JsonKey(name: 'birthday')
  final String? birthday;
  @JsonKey(name: 'place_of_birth')
  final String? placeOfBirth;
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;
  final double? popularity;

  const Actor({
    required this.id,
    required this.name,
    this.biography,
    this.profilePath,
    this.birthday,
    this.placeOfBirth,
    this.knownForDepartment,
    this.popularity,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
  Map<String, dynamic> toJson() => _$ActorToJson(this);

  String get profileUrl {
    if (profilePath == null) return '';
    return 'https://image.tmdb.org/t/p/w500$profilePath';
  }

  String get fullProfileUrl {
    if (profilePath == null) return '';
    return 'https://image.tmdb.org/t/p/original$profilePath';
  }
}
