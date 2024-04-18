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
  final String? taskId;
  final TasksRepository _tasksRepo;

  TaskDetailsCubit({
    @factoryParam required this.taskId,
    required TasksRepository tasksRepo,
  })  : _tasksRepo = tasksRepo,
        super(const TaskDetailsInitial()) {
    _loadData();
  }

  Future<void> onTaskSave(Task item) async {
    if (state is TaskDetailsOnNew) {
      emit(const TaskDetailsLoading());

      final response = await _tasksRepo.add(item);

      if (response.isRight()) {
        locator.get<AppNavigator>().router.pop();
      }
    } else if (state is TaskDetailsOnSelected) {
      emit(const TaskDetailsLoading());

      final response = await _tasksRepo.update(item);

      if (response.isRight()) {
        locator.get<AppNavigator>().router.pop();
      }
    }
  }

  Future<void> onTaskRemove() async {
    final response = await _tasksRepo.delete(taskId!);

    if (response.isRight()) {
      locator.get<AppNavigator>().router.pop();
    }
  }

  void _loadData() async {
    if (taskId == null) {
      _setupTaskCandidate();
    } else {
      await _fetchTaskData();
    }
  }

  void _setupTaskCandidate() {
    emit(TaskDetailsOnNew(Task.candidate()));
  }

  Future<void> _fetchTaskData() async {
    emit(const TaskDetailsLoading());

    final response = await _tasksRepo.findById(taskId!);

    response.fold(
      (error) => emit(TaskDetailsError(error)),
      (data) => emit(TaskDetailsOnSelected(data)),
    );
  }
}
