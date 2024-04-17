import 'package:sembast/timestamp.dart';
import 'package:task_manager_app/data/models/enums/priority/dto/priority_dto.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:task_manager_app/data/models/enums/task_status/dto/task_status_dto.dart';

part 'task_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskDto {
  final String id;
  final String title;
  final String description;
  final PriorityDto priority;
  @JsonKey(fromJson: _timestampConverter, toJson: _timestampConverter)
  final Timestamp createdAt;
  @JsonKey(fromJson: _timestampConverter, toJson: _timestampConverter)
  final Timestamp deadlineAt;
  final TaskStatusDto status;

  TaskDto({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.createdAt,
    required this.deadlineAt,
    required this.status,
  });

  static Timestamp _timestampConverter(dynamic value) {
    return value as Timestamp;
  }

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDtoToJson(this);
}
