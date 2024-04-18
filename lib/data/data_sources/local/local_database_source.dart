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
  Future<Either<GeneralError, void>> update<T>(
      Map<String, dynamic> rawData, String id);
  Future<Either<GeneralError, void>> delete<T>(String id);
  Future<Either<GeneralError, Map<String, dynamic>?>> findById<T>(String id);
  Stream<List<Map<String, Object?>>> queryListener<T>(Finder finder);
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
  Future<Either<GeneralError, void>> update<T>(
    Map<String, dynamic> rawData,
    String id,
  ) async {
    try {
      log(
        'Updating item ($T) in local database',
        name: Statics.loggerLocalDbName,
      );

      await _collectionRef<T>().update(
        _db,
        finder: Finder(filter: Filter.equals('id', id)),
        rawData,
      );

      return right(null);
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerLocalDbName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  @override
  Future<Either<GeneralError, void>> delete<T>(String id) async {
    try {
      log(
        'Removing item ($T) from local database',
        name: Statics.loggerLocalDbName,
      );

      await _collectionRef<T>().delete(
        _db,
        finder: Finder(filter: Filter.equals('id', id)),
      );

      return right(null);
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerLocalDbName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  @override
  Stream<List<Map<String, Object?>>> queryListener<T>(Finder finder) {
    log(
      'Query listener set ($T) filter: ${finder.toString()}',
      name: Statics.loggerLocalDbName,
    );

    return _collectionRef<T>().query(finder: finder).onSnapshots(_db).map(
          (event) => event.map((e) => e.value).toList(),
        );
  }

  @override
  Future<Either<GeneralError, Map<String, dynamic>?>> findById<T>(
      String id) async {
    try {
      log(
        'Find item ($T) in local database',
        name: Statics.loggerLocalDbName,
      );

      final rawData = await _collectionRef<T>().findFirst(
        _db,
        finder: Finder(filter: Filter.equals('id', id)),
      );

      if (rawData == null) {
        return left(GeneralError.dataNotFound());
      } else {
        return right(rawData.value);
      }
    } catch (ex, stackTrace) {
      log(ex.toString(),
          name: Statics.loggerLocalDbName, stackTrace: stackTrace);

      return left(GeneralError.unexpected());
    }
  }

  StoreRef<int, Map<String, Object?>> _collectionRef<T>() {
    final map = {
      TaskDto: _tasksCollection,
    };

    return map[T]!;
  }
}
