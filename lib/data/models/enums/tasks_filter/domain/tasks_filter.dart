import 'package:task_manager_app/data/models/enums/tasks_filter/dto/tasks_filter_dto.dart';

enum TasksFilter {
  all,
  today,
  highPriority;

  TasksFilterDto toDto() {
    switch (this) {
      case TasksFilter.all:
        return TasksFilterDto.all;
      case TasksFilter.today:
        return TasksFilterDto.today;
      case TasksFilter.highPriority:
        return TasksFilterDto.highPriority;
      default:
        return TasksFilterDto.all;
    }
  }

  String get label {
    switch (this) {
      case TasksFilter.all:
        return 'All';
      case TasksFilter.today:
        return 'Today';
      case TasksFilter.highPriority:
        return 'High priority';
    }
  }
}
