import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager_app/data/models/enums/priority/domain/priority.dart';
import 'package:task_manager_app/data/repositories/tasks_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/task/domain/task.dart';

part 'tasks_state.dart';

@injectable
class TasksCubit extends Cubit<TasksState> {
  final TasksRepository _tasksRepo;

  TasksCubit({
    required TasksRepository tasksRepo,
  })  : _tasksRepo = tasksRepo,
        super(const TasksInitial());

  Future<void> addTask() async {
    await _tasksRepo.add(
      Task(
        id: const Uuid().v4(),
        title: 'test',
        description: 'descritpion',
        priority: Priority.medium,
        deadlineAt: DateTime(2024, 4, 21, 12, 0, 0, 0, 0),
      ),
    );
  }

  Future<void> fetchAll() async {
    final response = await _tasksRepo.fetchAll();

    response.fold((l) {
      print(l);
    }, (r) {
      print(r);
    });
  }
}
