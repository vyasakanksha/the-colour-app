import 'package:my_app/consts/colours.dart' as Colours;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'selected_colour.freezed.dart';
part 'selected_colour.g.dart';

@freezed
class SelectedColour with _$SelectedColour {
  const factory SelectedColour(
      {
      // ignore: invalid_annotation_target
      @JsonKey(name: 'id') required String id,
      required String colour}) = _SelectedColour;

  factory SelectedColour.fromJson(Map<String, dynamic> json) =>
      _$SelectedColourFromJson(json);
}
