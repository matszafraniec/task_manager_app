import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../data_providers/tasks_service/tasks_service.dart';
import '../models/general_error/domain/general_error.dart';
import '../models/task/domain/task.dart' as model;

abstract class TasksRepository {
  Future<Either<GeneralError, void>> add(model.Task item);
  //TODO: add edit function

  Future<Either<GeneralError, void>> delete(model.Task item);
  Future<Either<GeneralError, List<model.Task>>> fetchAll();
  Stream<List<model.Task>> queryAllListener();
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
  Future<Either<GeneralError, void>> delete(model.Task item) {
    return _service.delete(item.id);
  }

  @override
  Stream<List<model.Task>> queryAllListener() => _service
      .queryAllListener()
      .map((data) => data.map(model.Task.fromDto).toList());

  @override
  Future<Either<GeneralError, List<model.Task>>> fetchAll() async {
    return _service.fetchAll();
  }
}
