// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_providers/tasks_service/tasks_service.dart' as _i5;
import '../data/data_providers/weather_service/remote/weather_remote_service.dart'
    as _i7;
import '../data/data_providers/weather_service/weather_service.dart' as _i8;
import '../data/data_sources/local/local_database_source.dart' as _i6;
import '../data/repositories/location_repository.dart' as _i4;
import '../data/repositories/tasks_repository.dart' as _i9;
import '../data/repositories/weather_repository.dart' as _i10;
import '../logic/cubits/notifications/notifications_cubit.dart' as _i11;
import '../logic/cubits/task_details/task_details_cubit.dart' as _i12;
import '../logic/cubits/tasks/tasks_cubit.dart' as _i13;
import '../logic/cubits/weather/weather_cubit.dart' as _i14;
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
    gh.lazySingleton<_i4.LocationRepository>(
        () => _i4.LocationRepositoryImpl());
    gh.lazySingleton<_i5.TasksService>(
        () => _i5.TasksServiceImpl(gh<_i6.LocalDatabaseSource>()));
    gh.lazySingleton<_i7.WeatherRemoteService>(
        () => _i7.WeatherRemoteServiceImpl());
    gh.lazySingleton<_i8.WeatherService>(() =>
        _i8.WeatherServiceImpl(remoteService: gh<_i7.WeatherRemoteService>()));
    gh.lazySingleton<_i9.TasksRepository>(
        () => _i9.TasksRepositoryImpl(gh<_i5.TasksService>()));
    gh.lazySingleton<_i10.WeatherRepository>(
        () => _i10.WeatherRepositoryImpl(gh<_i8.WeatherService>()));
    gh.factory<_i11.NotificationsCubit>(
        () => _i11.NotificationsCubit(tasksRepo: gh<_i9.TasksRepository>()));
    gh.factoryParam<_i12.TaskDetailsCubit, String?, dynamic>((
      taskId,
      _,
    ) =>
        _i12.TaskDetailsCubit(
          taskId: taskId,
          tasksRepo: gh<_i9.TasksRepository>(),
        ));
    gh.factory<_i13.TasksCubit>(
        () => _i13.TasksCubit(tasksRepo: gh<_i9.TasksRepository>()));
    gh.factory<_i14.WeatherCubit>(() => _i14.WeatherCubit(
          weatherRepo: gh<_i10.WeatherRepository>(),
          locationRepo: gh<_i4.LocationRepository>(),
        ));
    return this;
  }
}
