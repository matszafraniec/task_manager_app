// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_providers/tasks_service/tasks_service.dart' as _i4;
import '../data/data_sources/local/local_database_source.dart' as _i5;
import '../data/repositories/tasks_repository.dart' as _i6;
import '../logic/cubits/task_details/task_details_cubit.dart' as _i7;
import '../logic/cubits/tasks/tasks_cubit.dart' as _i8;
import '../presentation/common/routing/app_navigator.dart' as _i3;

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
    gh.singleton<_i3.AppNavigator>(() => _i3.AppNavigator());
    gh.lazySingleton<_i4.TasksService>(
        () => _i4.TasksServiceImpl(gh<_i5.LocalDatabaseSource>()));
    gh.lazySingleton<_i6.TasksRepository>(
        () => _i6.TasksRepositoryImpl(gh<_i4.TasksService>()));
    gh.factoryParam<_i7.TaskDetailsCubit, String, dynamic>((
      taskId,
      _,
    ) =>
        _i7.TaskDetailsCubit(
          taskId: taskId,
          tasksRepo: gh<_i6.TasksRepository>(),
        ));
    gh.factory<_i8.TasksCubit>(
        () => _i8.TasksCubit(tasksRepo: gh<_i6.TasksRepository>()));
    return this;
  }
}
