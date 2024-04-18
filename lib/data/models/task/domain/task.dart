import 'package:sembast/timestamp.dart';
import 'package:task_manager_app/data/common/extensions.dart';
import 'package:task_manager_app/data/models/enums/task_status/domain/task_status.dart';
import 'package:task_manager_app/data/models/task/dto/task_dto.dart';
import 'package:intl/intl.dart';

import '../../enums/priority/domain/priority.dart';

class Task {
  final String id;
  String title;
  String description;
  Priority priority;
  final DateTime createdAt;
  DateTime deadlineAt;
  TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.deadlineAt,
    required this.createdAt,
    required this.status,
  });

  factory Task.fromDto(TaskDto dto) => Task(
        id: dto.id,
        title: dto.title,
        description: dto.description,
        priority: Priority.fromDto(dto.priority),
        createdAt: dto.createdAt.toDateTime(),
        deadlineAt: dto.deadlineAt.toDateTime(),
        status: TaskStatus.fromDto(dto.status),
      );

  TaskDto toDto() => TaskDto(
        id: id,
        title: title,
        description: description,
        priority: priority.toDto(),
        createdAt: Timestamp.fromDateTime(createdAt),
        deadlineAt: Timestamp.fromDateTime(deadlineAt),
        status: status.toDto(),
      );

  String get deadlineAtFormatted {
    if (deadlineAt.isToday) {
      return 'Today, ${DateFormat('HH:mm').format(deadlineAt)}';
    } else if (deadlineAt.isYesterday) {
      return 'Yesterday, ${DateFormat('HH:mm').format(deadlineAt)}';
    }

    if (DateTime.now().year != deadlineAt.year) {
      return DateFormat('dd.MM.yyyy, HH:mm').format(deadlineAt);
    }

    return DateFormat('dd.MM, HH:mm').format(deadlineAt);
  }
}
