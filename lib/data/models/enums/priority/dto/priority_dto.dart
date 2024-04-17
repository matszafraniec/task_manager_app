import 'package:json_annotation/json_annotation.dart';

enum PriorityDto {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
}
