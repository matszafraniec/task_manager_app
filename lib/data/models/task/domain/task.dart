import 'package:task_manager_app/data/models/task/dto/task_dto.dart';

import '../../enums/priority/domain/priority.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final Priority priority;
  final DateTime deadlineAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.deadlineAt,
  });

  factory Task.fromDto(TaskDto dto) => Task(
        id: dto.id,
        title: dto.title,
        description: dto.description,
        priority: Priority.fromDto(dto.priority),
        deadlineAt: dto.deadlineAt.toDateTime(),
      );
}
