import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser(
      {required String id,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'time_in') required DateTime timeIn,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'time_out') required DateTime timeOut}) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
