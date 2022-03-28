// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Location _$$_LocationFromJson(Map json) => _$_Location(
      id: json['id'] as String,
      timeIn: DateTime.parse(json['time_in'] as String),
      timeOut: DateTime.parse(json['time_out'] as String),
      details: Map<String, dynamic>.from(json['details'] as Map),
      permission: json['permission'] as bool,
    );

Map<String, dynamic> _$$_LocationToJson(_$_Location instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time_in': instance.timeIn.toIso8601String(),
      'time_out': instance.timeOut.toIso8601String(),
      'details': instance.details,
      'permission': instance.permission,
    };
