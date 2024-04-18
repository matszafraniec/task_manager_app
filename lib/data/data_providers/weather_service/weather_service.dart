import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../models/general_error/domain/general_error.dart';
import '../../models/weather_current_conditions/remote/weather_current_conditions_remote.dart';
import 'remote/weather_remote_service.dart';

abstract class WeatherService {
  Future<Either<GeneralError, String>> findLocationKeyByGeoposition(
      double lat, double lon);

  Future<Either<GeneralError, WeatherCurrentConditionsRemote>>
      loadCurrentConditions(
    String locationKey,
  );
}

@LazySingleton(as: WeatherService)
class WeatherServiceImpl extends WeatherService {
  final WeatherRemoteService _remoteService;

  WeatherServiceImpl({
    required WeatherRemoteService remoteService,
  }) : _remoteService = remoteService;

  @override
  Future<Either<GeneralError, String>> findLocationKeyByGeoposition(
      double lat, double lon) {
    return _remoteService.findLocationKeyByGeoposition(lat, lon);
  }

  @override
  Future<Either<GeneralError, WeatherCurrentConditionsRemote>>
      loadCurrentConditions(String locationKey) async {
    return _remoteService.loadCurrentConditions(locationKey);
  }
}
