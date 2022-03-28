// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'selected_colour.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SelectedColour _$SelectedColourFromJson(Map<String, dynamic> json) {
  return _SelectedColour.fromJson(json);
}

/// @nodoc
class _$SelectedColourTearOff {
  const _$SelectedColourTearOff();

  _SelectedColour call(
      {@JsonKey(name: 'id') required String id, required String colour}) {
    return _SelectedColour(
      id: id,
      colour: colour,
    );
  }

  SelectedColour fromJson(Map<String, Object?> json) {
    return SelectedColour.fromJson(json);
  }
}

/// @nodoc
const $SelectedColour = _$SelectedColourTearOff();

/// @nodoc
mixin _$SelectedColour {
// ignore: invalid_annotation_target
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  String get colour => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SelectedColourCopyWith<SelectedColour> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedColourCopyWith<$Res> {
  factory $SelectedColourCopyWith(
          SelectedColour value, $Res Function(SelectedColour) then) =
      _$SelectedColourCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'id') String id, String colour});
}

/// @nodoc
class _$SelectedColourCopyWithImpl<$Res>
    implements $SelectedColourCopyWith<$Res> {
  _$SelectedColourCopyWithImpl(this._value, this._then);

  final SelectedColour _value;
  // ignore: unused_field
  final $Res Function(SelectedColour) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? colour = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      colour: colour == freezed
          ? _value.colour
          : colour // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$SelectedColourCopyWith<$Res>
    implements $SelectedColourCopyWith<$Res> {
  factory _$SelectedColourCopyWith(
          _SelectedColour value, $Res Function(_SelectedColour) then) =
      __$SelectedColourCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: 'id') String id, String colour});
}

/// @nodoc
class __$SelectedColourCopyWithImpl<$Res>
    extends _$SelectedColourCopyWithImpl<$Res>
    implements _$SelectedColourCopyWith<$Res> {
  __$SelectedColourCopyWithImpl(
      _SelectedColour _value, $Res Function(_SelectedColour) _then)
      : super(_value, (v) => _then(v as _SelectedColour));

  @override
  _SelectedColour get _value => super._value as _SelectedColour;

  @override
  $Res call({
    Object? id = freezed,
    Object? colour = freezed,
  }) {
    return _then(_SelectedColour(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      colour: colour == freezed
          ? _value.colour
          : colour // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SelectedColour implements _SelectedColour {
  const _$_SelectedColour(
      {@JsonKey(name: 'id') required this.id, required this.colour});

  factory _$_SelectedColour.fromJson(Map<String, dynamic> json) =>
      _$$_SelectedColourFromJson(json);

  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'id')
  final String id;
  @override
  final String colour;

  @override
  String toString() {
    return 'SelectedColour(id: $id, colour: $colour)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SelectedColour &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.colour, colour));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(colour));

  @JsonKey(ignore: true)
  @override
  _$SelectedColourCopyWith<_SelectedColour> get copyWith =>
      __$SelectedColourCopyWithImpl<_SelectedColour>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SelectedColourToJson(this);
  }
}

abstract class _SelectedColour implements SelectedColour {
  const factory _SelectedColour(
      {@JsonKey(name: 'id') required String id,
      required String colour}) = _$_SelectedColour;

  factory _SelectedColour.fromJson(Map<String, dynamic> json) =
      _$_SelectedColour.fromJson;

  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'id')
  String get id;
  @override
  String get colour;
  @override
  @JsonKey(ignore: true)
  _$SelectedColourCopyWith<_SelectedColour> get copyWith =>
      throw _privateConstructorUsedError;
}
