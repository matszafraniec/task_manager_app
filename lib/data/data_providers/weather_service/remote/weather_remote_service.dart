import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../models/general_error/domain/general_error.dart';
import '../../../models/weather_current_conditions/remote/weather_current_conditions_remote.dart';

abstract class WeatherRemoteService {
  Future<Either<GeneralError, String>> findLocationKeyByGeoposition(
      double lat, double lon);

  Future<Either<GeneralError, WeatherCurrentConditionsRemote>>
      loadCurrentConditions(String locationKey);
}

@LazySingleton(as: WeatherRemoteService)
class WeatherRemoteServiceImpl extends WeatherRemoteService {
  final _dio = Dio();
  static const _baseUrl = 'http://dataservice.accuweather.com';

  WeatherRemoteServiceImpl() {
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  @override
  Future<Either<GeneralError, String>> findLocationKeyByGeoposition(
    double lat,
    double lon,
  ) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/locations/v1/cities/geoposition/search',
        queryParameters: {
          //TODO: pass key later
          'apikey': '76uBXEHFHnFUzhhHJPCneAE4KuXpXLA0',
          'q': '$lat,$lon',
          'details': false,
        },
      );

      if (response.statusCode == 200) {
        final locationKey = response.data['Key'];

        return right(locationKey);
      }

      return left(GeneralError.unexpected());
    } on DioException catch (exception) {
      return left(
          GeneralError(exception.message ?? GeneralError.unexpected().message));
    }
  }

  @override
  Future<Either<GeneralError, WeatherCurrentConditionsRemote>>
      loadCurrentConditions(
    String locationKey,
  ) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/currentconditions/v1/$locationKey',
        queryParameters: {
          //TODO: add key later
          'apikey': '76uBXEHFHnFUzhhHJPCneAE4KuXpXLA0',
          'details': true,
        },
      );

      if (response.statusCode == 200) {
        final json = (response.data as List).first;

        return right(WeatherCurrentConditionsRemote.fromJson(json));
      }

      return left(GeneralError.unexpected());
    } on DioException catch (exception) {
      return left(
          GeneralError(exception.message ?? GeneralError.unexpected().message));
    }
  }
}
