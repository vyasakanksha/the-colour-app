import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  const factory Location({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'id') required String id,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'time_in') required DateTime timeIn,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'time_out') required DateTime timeOut,
    required Map<String, dynamic> details,
    required bool permission,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
