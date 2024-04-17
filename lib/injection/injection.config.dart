// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_providers/tasks_service/tasks_service.dart' as _i3;
import '../data/data_sources/local/local_database_source.dart' as _i4;
import '../data/repositories/tasks_repository.dart' as _i5;
import '../logic/cubits/tasks/tasks_cubit.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.TasksService>(
        () => _i3.TasksServiceImpl(gh<_i4.LocalDatabaseSource>()));
    gh.lazySingleton<_i5.TasksRepository>(
        () => _i5.TasksRepositoryImpl(gh<_i3.TasksService>()));
    gh.factory<_i6.TasksCubit>(
        () => _i6.TasksCubit(tasksRepo: gh<_i5.TasksRepository>()));
    return this;
  }
}
