// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map json) => _$_AppUser(
      id: json['id'] as String,
      timeIn: DateTime.parse(json['time_in'] as String),
      timeOut: DateTime.parse(json['time_out'] as String),
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time_in': instance.timeIn.toIso8601String(),
      'time_out': instance.timeOut.toIso8601String(),
    };
