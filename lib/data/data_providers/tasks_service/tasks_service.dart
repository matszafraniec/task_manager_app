import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager_app/data/models/task/dto/task_dto.dart';

import '../../common/statics.dart';
import '../../data_sources/local/local_database_source.dart';
import '../../models/general_error/domain/general_error.dart';
import '../../models/task/domain/task.dart' as domain;

abstract class TasksService {
  Future<Either<GeneralError, void>> add(domain.Task item);
  Future<Either<GeneralError, void>> delete(String id);
  Future<Either<GeneralError, List<domain.Task>>> fetchAll();
  Either<GeneralError, Stream<List<TaskDto>>> queryAllListener();
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

      return Left(GeneralError.unexpected());
    }
  }

  @override
  Future<Either<GeneralError, void>> delete(String id) {
    return _db.delete<TaskDto>(id);
  }

  @override
  Either<GeneralError, Stream<List<TaskDto>>> queryAllListener() {
    try {
      return Right(
        _db.queryAllListener<TaskDto>().map(
              (data) => data.map(TaskDto.fromJson).toList(),
            ),
      );
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerTasksServiceName, stackTrace: stackTrace);

      return Left(GeneralError.unexpected());
    }
  }

  @override
  Future<Either<GeneralError, List<domain.Task>>> fetchAll() async {
    final response = await _db.fetchAll<TaskDto>();

    return response.fold(
      (error) => Left(error),
      (data) {
        final tasksDto = data.map((e) => TaskDto.fromJson(e));

        return Right(tasksDto.map((e) => domain.Task.fromDto(e)).toList());
      },
    );
  }
}
