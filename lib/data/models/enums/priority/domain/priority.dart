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
