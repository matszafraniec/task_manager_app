import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:task_manager_app/data/models/task/dto/task_dto.dart';

import '../../common/statics.dart';
import '../../models/general_error/domain/general_error.dart';

abstract class LocalDatabaseSource {
  Future<void> setup();

  Future<Either<GeneralError, void>> add<T>(Map<String, dynamic> rawData);
  Future<Either<GeneralError, void>> delete<T>(String key);
  Future<Either<GeneralError, List<Map<String, dynamic>>>> fetchAll<T>();
  Stream<List<Map<String, Object?>>> queryAllListener<T>();
}

class LocalDatabaseSourceImpl extends LocalDatabaseSource {
  late Database _db;
  late StoreRef<int, Map<String, Object?>> _tasksCollection;

  @override
  Future<void> setup() async {
    final dir = await getApplicationDocumentsDirectory();

    final dbPath = '${dir.path}/tasks.db';
    final dbFactory = databaseFactoryIo;

    _db = await dbFactory.openDatabase(dbPath);

    _tasksCollection = intMapStoreFactory.store('tasks');
  }

  @override
  Future<Either<GeneralError, void>> add<T>(
      Map<String, dynamic> rawData) async {
    try {
      log(
        'Adding item ($T) to local database',
        name: Statics.loggerLocalDbName,
      );

      await _collectionRef<T>().add(_db, rawData);

      return right(null);
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerLocalDbName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  @override
  Future<Either<GeneralError, void>> delete<T>(String key) async {
    try {
      log(
        'Removing item ($T) from local database',
        name: Statics.loggerLocalDbName,
      );

      await _collectionRef<T>().delete(
        _db,
        finder: Finder(
          filter: Filter.equals('key', key),
        ),
      );

      return right(null);
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerLocalDbName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  @override
  Future<Either<GeneralError, List<Map<String, dynamic>>>> fetchAll<T>() async {
    try {
      log(
        'Fetching all items ($T) from local database',
        name: Statics.loggerLocalDbName,
      );

      final records = await _collectionRef<T>().find(_db);

      return right(records.map((e) => e.value).toList());
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerLocalDbName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  @override
  Stream<List<Map<String, Object?>>> queryAllListener<T>() {
    log(
      'Query all listener set ($T)',
      name: Statics.loggerLocalDbName,
    );

    return _collectionRef<T>().query().onSnapshots(_db).map(
          (event) => event
              .map(
                (e) => e.value,
              )
              .toList(),
        );
  }

  StoreRef<int, Map<String, Object?>> _collectionRef<T>() {
    final map = {
      TaskDto: _tasksCollection,
    };

    return map[T]!;
  }
}
