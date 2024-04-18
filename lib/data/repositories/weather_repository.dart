import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager_app/data/models/location/domain/location.dart';

import '../data_providers/weather_service/weather_service.dart';
import '../models/general_error/domain/general_error.dart';
import '../models/weather_current_conditions/domain/weather_current_conditions.dart';

abstract class WeatherRepository {
  Future<Either<GeneralError, String>> findLocationKeyByGeoposition(
    Location location,
  );

  Future<Either<GeneralError, WeatherCurrentConditions>> loadCurrentConditions(
    String locationKey,
  );
}

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherService _service;

  WeatherRepositoryImpl(this._service);

  @override
  Future<Either<GeneralError, String>> findLocationKeyByGeoposition(
      Location location) async {
    return _service.findLocationKeyByGeoposition(location.lat, location.lon);
  }

  @override
  Future<Either<GeneralError, WeatherCurrentConditions>> loadCurrentConditions(
      String locationKey) async {
    final response = await _service.loadCurrentConditions(locationKey);

    return response.fold(
      (error) => left(error),
      (data) => right(WeatherCurrentConditions.fromRemote(data)),
    );
  }
}
