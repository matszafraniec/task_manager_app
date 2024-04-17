import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/enums/priority/dto/priority_dto.dart';

enum Priority {
  low,
  medium,
  high;

  static Priority fromDto(PriorityDto value) {
    switch (value) {
      case PriorityDto.low:
        return Priority.low;
      case PriorityDto.medium:
        return Priority.medium;
      case PriorityDto.high:
        return Priority.high;
      default:
        return Priority.medium;
    }
  }
}

extension PriorityExtension on Priority {
  PriorityDto toDto() {
    switch (this) {
      case Priority.low:
        return PriorityDto.low;
      case Priority.medium:
        return PriorityDto.medium;
      case Priority.high:
        return PriorityDto.high;
      default:
        return PriorityDto.medium;
    }
  }

  Color get color {
    switch (this) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.blue;
      case Priority.high:
        return Colors.red;
    }
  }

  String get label {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
    }
  }
}
