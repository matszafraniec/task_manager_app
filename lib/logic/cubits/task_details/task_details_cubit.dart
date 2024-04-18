import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager_app/data/models/general_error/domain/general_error.dart';
import 'package:task_manager_app/data/models/task/domain/task.dart';
import 'package:task_manager_app/data/repositories/tasks_repository.dart';

import '../../../injection/injection.dart';
import '../../../presentation/common/routing/app_navigator.dart';

part 'task_details_state.dart';

@injectable
class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  final String taskId;
  final TasksRepository _tasksRepo;

  TaskDetailsCubit({
    @factoryParam required this.taskId,
    required TasksRepository tasksRepo,
  })  : _tasksRepo = tasksRepo,
        super(const TaskDetailsInitial()) {
    _loadData();
  }

  void _loadData() async {
    emit(const TaskDetailsLoading());

    final response = await _tasksRepo.findById(taskId);

    response.fold(
      (error) => emit(TaskDetailsError(error)),
      (data) => emit(TaskDetailsLoaded(data)),
    );
  }

  Future<void> onTaskRemove() async {
    final response = await _tasksRepo.delete(taskId);

    if (response.isRight()) {
      locator.get<AppNavigator>().router.pop();
    }
  }
}
