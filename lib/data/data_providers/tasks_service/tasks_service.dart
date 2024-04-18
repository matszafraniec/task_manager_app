import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';
import 'package:task_manager_app/data/models/enums/tasks_filter/dto/tasks_filter_dto.dart';
import 'package:task_manager_app/data/models/task/dto/task_dto.dart';

import '../../common/statics.dart';
import '../../data_sources/local/local_database_source.dart';
import '../../models/general_error/domain/general_error.dart';
import '../../models/task/domain/task.dart' as domain;

abstract class TasksService {
  Future<Either<GeneralError, void>> add(domain.Task item);
  Future<Either<GeneralError, void>> update(domain.Task item);
  Future<Either<GeneralError, void>> delete(String id);
  Future<Either<GeneralError, TaskDto>> findById(String id);
  Either<GeneralError, Stream<List<TaskDto>>> queryListener(
    TasksFilterDto filter,
  );
  Either<GeneralError, Stream<List<TaskDto>>> queryListenerWithCustomFilter(
    Filter filter,
  );
}

@LazySingleton(as: TasksService)
class TasksServiceImpl extends TasksService {
  final LocalDatabaseSource _db;

  TasksServiceImpl(this._db);

  @override
  Future<Either<GeneralError, void>> add(domain.Task item) async {
    try {
      final dbModel = item.toDto();

      return _db.add<TaskDto>(dbModel.toJson());
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerTasksServiceName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  @override
  Future<Either<GeneralError, void>> update(domain.Task item) async {
    try {
      final dbModel = item.toDto();

      return _db.update<TaskDto>(dbModel.toJson(), item.id);
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerTasksServiceName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  @override
  Future<Either<GeneralError, void>> delete(String id) async {
    return _db.delete<TaskDto>(id);
  }

  @override
  Either<GeneralError, Stream<List<TaskDto>>> queryListener(
      TasksFilterDto filter) {
    try {
      return right(
        _db
            .queryListener<TaskDto>(filter.toDbFilter())
            .map((data) => data.map(TaskDto.fromJson).toList()),
      );
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerTasksServiceName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  @override
  Either<GeneralError, Stream<List<TaskDto>>> queryListenerWithCustomFilter(
      Filter filter) {
    try {
      return right(
        _db
            .queryListener<TaskDto>(Finder(filter: filter))
            .map((data) => data.map(TaskDto.fromJson).toList()),
      );
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerTasksServiceName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  @override
  Future<Either<GeneralError, TaskDto>> findById(String id) async {
    final response = await _db.findById<TaskDto>(id);

    return response.fold(
      (error) => left(error),
      (data) => right(TaskDto.fromJson(data!)),
    );
  }
}
