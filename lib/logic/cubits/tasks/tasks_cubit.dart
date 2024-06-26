import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager_app/data/models/enums/tasks_filter/domain/tasks_filter.dart';
import 'package:task_manager_app/data/models/general_error/domain/general_error.dart';
import 'package:task_manager_app/data/repositories/tasks_repository.dart';

import '../../../data/models/task/domain/task.dart';

part 'tasks_state.dart';

@injectable
class TasksCubit extends Cubit<TasksState> {
  final TasksRepository _tasksRepo;
  late StreamSubscription _querySubscription;

  TasksCubit({
    required TasksRepository tasksRepo,
  })  : _tasksRepo = tasksRepo,
        super(const TasksInitial()) {
    _dataListenAndPump();
  }

  void _dataListenAndPump() async {
    emit(const TasksLoading());

    _tasksRepo.queryListener(TasksFilter.all).fold(
      (error) => emit(TasksPopulatedFailure(error)),
      (stream) {
        _querySubscription = stream.listen(
          (tasks) => emit(TasksPopulatedSuccess(tasks, TasksFilter.all)),
        );
      },
    );
  }

  void onFilterSet(TasksFilter filter) {
    emit(const TasksLoading());

    _tasksRepo.queryListener(filter).fold(
      (error) => emit(TasksPopulatedFailure(error)),
      (stream) async {
        await _querySubscription.cancel();

        _querySubscription = stream.listen(
          (tasks) => emit(TasksPopulatedSuccess(tasks, filter)),
        );
      },
    );
  }

  Future<void> onTaskRemove(Task item) async {
    await _tasksRepo.delete(item.id);
  }

  @override
  Future<void> close() async {
    await _querySubscription.cancel();
    return super.close();
  }
}
