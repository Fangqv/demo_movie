// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Actor _$ActorFromJson(Map<String, dynamic> json) => Actor(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  biography: json['biography'] as String?,
  profilePath: json['profile_path'] as String?,
  birthday: json['birthday'] as String?,
  placeOfBirth: json['place_of_birth'] as String?,
  knownForDepartment: json['known_for_department'] as String?,
  popularity: (json['popularity'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ActorToJson(Actor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'biography': instance.biography,
  'profile_path': instance.profilePath,
  'birthday': instance.birthday,
  'place_of_birth': instance.placeOfBirth,
  'known_for_department': instance.knownForDepartment,
  'popularity': instance.popularity,
};
