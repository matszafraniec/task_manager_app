import 'package:json_annotation/json_annotation.dart';

enum TaskStatusDto {
  @JsonValue('planned')
  planned,
  @JsonValue('inProgress')
  inProgress,
  @JsonValue('done')
  done,
}
