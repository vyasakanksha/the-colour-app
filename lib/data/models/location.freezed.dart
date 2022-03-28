// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
class _$LocationTearOff {
  const _$LocationTearOff();

  _Location call(
      {@JsonKey(name: 'id') required String id,
      @JsonKey(name: 'time_in') required DateTime timeIn,
      @JsonKey(name: 'time_out') required DateTime timeOut,
      required Map<String, dynamic> details,
      required bool permission}) {
    return _Location(
      id: id,
      timeIn: timeIn,
      timeOut: timeOut,
      details: details,
      permission: permission,
    );
  }

  Location fromJson(Map<String, Object?> json) {
    return Location.fromJson(json);
  }
}

/// @nodoc
const $Location = _$LocationTearOff();

/// @nodoc
mixin _$Location {
// ignore: invalid_annotation_target
  @JsonKey(name: 'id')
  String get id =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'time_in')
  DateTime get timeIn =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'time_out')
  DateTime get timeOut => throw _privateConstructorUsedError;
  Map<String, dynamic> get details => throw _privateConstructorUsedError;
  bool get permission => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'time_in') DateTime timeIn,
      @JsonKey(name: 'time_out') DateTime timeOut,
      Map<String, dynamic> details,
      bool permission});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res> implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  final Location _value;
  // ignore: unused_field
  final $Res Function(Location) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? timeIn = freezed,
    Object? timeOut = freezed,
    Object? details = freezed,
    Object? permission = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timeIn: timeIn == freezed
          ? _value.timeIn
          : timeIn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeOut: timeOut == freezed
          ? _value.timeOut
          : timeOut // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: details == freezed
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      permission: permission == freezed
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$LocationCopyWith(_Location value, $Res Function(_Location) then) =
      __$LocationCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'time_in') DateTime timeIn,
      @JsonKey(name: 'time_out') DateTime timeOut,
      Map<String, dynamic> details,
      bool permission});
}

/// @nodoc
class __$LocationCopyWithImpl<$Res> extends _$LocationCopyWithImpl<$Res>
    implements _$LocationCopyWith<$Res> {
  __$LocationCopyWithImpl(_Location _value, $Res Function(_Location) _then)
      : super(_value, (v) => _then(v as _Location));

  @override
  _Location get _value => super._value as _Location;

  @override
  $Res call({
    Object? id = freezed,
    Object? timeIn = freezed,
    Object? timeOut = freezed,
    Object? details = freezed,
    Object? permission = freezed,
  }) {
    return _then(_Location(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timeIn: timeIn == freezed
          ? _value.timeIn
          : timeIn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeOut: timeOut == freezed
          ? _value.timeOut
          : timeOut // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: details == freezed
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      permission: permission == freezed
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Location implements _Location {
  const _$_Location(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'time_in') required this.timeIn,
      @JsonKey(name: 'time_out') required this.timeOut,
      required this.details,
      required this.permission});

  factory _$_Location.fromJson(Map<String, dynamic> json) =>
      _$$_LocationFromJson(json);

  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'id')
  final String id;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'time_in')
  final DateTime timeIn;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'time_out')
  final DateTime timeOut;
  @override
  final Map<String, dynamic> details;
  @override
  final bool permission;

  @override
  String toString() {
    return 'Location(id: $id, timeIn: $timeIn, timeOut: $timeOut, details: $details, permission: $permission)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Location &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.timeIn, timeIn) &&
            const DeepCollectionEquality().equals(other.timeOut, timeOut) &&
            const DeepCollectionEquality().equals(other.details, details) &&
            const DeepCollectionEquality()
                .equals(other.permission, permission));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(timeIn),
      const DeepCollectionEquality().hash(timeOut),
      const DeepCollectionEquality().hash(details),
      const DeepCollectionEquality().hash(permission));

  @JsonKey(ignore: true)
  @override
  _$LocationCopyWith<_Location> get copyWith =>
      __$LocationCopyWithImpl<_Location>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationToJson(this);
  }
}

abstract class _Location implements Location {
  const factory _Location(
      {@JsonKey(name: 'id') required String id,
      @JsonKey(name: 'time_in') required DateTime timeIn,
      @JsonKey(name: 'time_out') required DateTime timeOut,
      required Map<String, dynamic> details,
      required bool permission}) = _$_Location;

  factory _Location.fromJson(Map<String, dynamic> json) = _$_Location.fromJson;

  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'id')
  String get id;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'time_in')
  DateTime get timeIn;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'time_out')
  DateTime get timeOut;
  @override
  Map<String, dynamic> get details;
  @override
  bool get permission;
  @override
  @JsonKey(ignore: true)
  _$LocationCopyWith<_Location> get copyWith =>
      throw _privateConstructorUsedError;
}
