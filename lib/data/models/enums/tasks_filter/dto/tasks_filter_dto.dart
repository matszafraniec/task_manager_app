import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';
import 'package:task_manager_app/data/models/enums/priority/dto/priority_dto.dart';
import 'package:task_manager_app/data/models/enums/task_status/domain/task_status.dart';

enum TasksFilterDto {
  all,
  today,
  inProgress,
  highPriority;

  Finder toDbFilter() {
    switch (this) {
      case TasksFilterDto.all:
        return Finder();
      case TasksFilterDto.today:
        final now = DateTime.now();
        final todayStartAt = DateTime(now.year, now.month, now.day, 0, 0, 0);
        final todayEndAt =
            DateTime(now.year, now.month, now.day, 23, 59, 59, 59, 59);

        return Finder(
          filter: Filter.and(
            [
              Filter.greaterThanOrEquals(
                'deadlineAt',
                Timestamp.fromDateTime(todayStartAt),
              ),
              Filter.lessThanOrEquals(
                'deadlineAt',
                Timestamp.fromDateTime(todayEndAt),
              )
            ],
          ),
        );
      case TasksFilterDto.inProgress:
        return Finder(
          filter: Filter.equals(
            'status',
            TaskStatus.inProgress.name,
          ),
        );
      case TasksFilterDto.highPriority:
        return Finder(
          filter: Filter.equals(
            'priority',
            PriorityDto.high.name,
          ),
        );
      default:
        return Finder();
    }
  }
}
