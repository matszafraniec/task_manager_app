import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager_app/data/models/enums/tasks_filter/domain/tasks_filter.dart';

import '../data_providers/tasks_service/tasks_service.dart';
import '../models/general_error/domain/general_error.dart';
import '../models/task/domain/task.dart' as model;

abstract class TasksRepository {
  Future<Either<GeneralError, void>> add(model.Task item);
  Future<Either<GeneralError, void>> update(model.Task item);
  Future<Either<GeneralError, void>> delete(String id);
  Future<Either<GeneralError, model.Task>> findById(String id);
  Either<GeneralError, Stream<List<model.Task>>> queryListener(
      TasksFilter filter);
}

@LazySingleton(as: TasksRepository)
class TasksRepositoryImpl extends TasksRepository {
  final TasksService _service;

  TasksRepositoryImpl(this._service);

  @override
  Future<Either<GeneralError, void>> add(model.Task item) {
    return _service.add(item);
  }

  @override
  Future<Either<GeneralError, void>> update(model.Task item) {
    return _service.update(item);
  }

  @override
  Future<Either<GeneralError, void>> delete(String id) {
    return _service.delete(id);
  }

  @override
  Either<GeneralError, Stream<List<model.Task>>> queryListener(
      TasksFilter filter) {
    return _service.queryListener(filter.toDto()).fold(
          (error) => left(error),
          (stream) => right(
            stream.map(
              (data) {
                final tasks = data.map(model.Task.fromDto).toList();
                tasks.sort((a, b) => b.deadlineAt.compareTo(a.deadlineAt));

                return tasks;
              },
            ),
          ),
        );
  }

  @override
  Future<Either<GeneralError, model.Task>> findById(String id) async {
    final response = await _service.findById(id);

    return response.fold(
      (error) => left(error),
      (data) => right(
        model.Task.fromDto(data),
      ),
    );
  }
}
