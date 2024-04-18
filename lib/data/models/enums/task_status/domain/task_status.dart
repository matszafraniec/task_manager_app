import 'package:flutter/material.dart';

import '../dto/task_status_dto.dart';

enum TaskStatus {
  planned,
  inProgress,
  done;

  static TaskStatus fromDto(TaskStatusDto value) {
    switch (value) {
      case TaskStatusDto.planned:
        return TaskStatus.planned;
      case TaskStatusDto.inProgress:
        return TaskStatus.inProgress;
      case TaskStatusDto.done:
        return TaskStatus.done;
      default:
        return TaskStatus.planned;
    }
  }
}

extension TaskStatusExtension on TaskStatus {
  TaskStatusDto toDto() {
    switch (this) {
      case TaskStatus.planned:
        return TaskStatusDto.planned;
      case TaskStatus.inProgress:
        return TaskStatusDto.inProgress;
      case TaskStatus.done:
        return TaskStatusDto.done;
      default:
        return TaskStatusDto.planned;
    }
  }

  String get label {
    switch (this) {
      case TaskStatus.planned:
        return 'Planned';
      case TaskStatus.inProgress:
        return 'In progress';
      case TaskStatus.done:
        return 'Done';
      default:
        return 'Planned';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.planned:
        return Colors.blue;
      case TaskStatus.inProgress:
        return Colors.orange;
      case TaskStatus.done:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}
