// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => TaskDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: $enumDecode(_$PriorityDtoEnumMap, json['priority']),
      deadlineAt: TaskDto._timestampConverter(json['deadlineAt']),
    );

Map<String, dynamic> _$TaskDtoToJson(TaskDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': _$PriorityDtoEnumMap[instance.priority]!,
      'deadlineAt': TaskDto._timestampConverter(instance.deadlineAt),
    };

const _$PriorityDtoEnumMap = {
  PriorityDto.low: 'low',
  PriorityDto.medium: 'medium',
  PriorityDto.high: 'high',
};
