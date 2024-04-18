import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/data/common/statics.dart';
import 'package:task_manager_app/data/models/weather_current_conditions/domain/weather_current_conditions.dart';
import 'package:task_manager_app/data/repositories/location_repository.dart';
import 'package:task_manager_app/data/repositories/weather_repository.dart';
import 'package:task_manager_app/logic/cubits/weather/weather_cubit.dart';

import 'weather_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<WeatherRepository>(),
  MockSpec<LocationRepository>(),
])
void main() {
  final mockWeatherRepo = MockWeatherRepository();
  final mockLocationRepo = MockLocationRepository();

  when(mockLocationRepo.obtainUserLocation()).thenAnswer(
    (_) async => right(Statics.defaultLocation),
  );
  when(mockWeatherRepo.findLocationKeyByGeoposition(any)).thenAnswer(
    (_) async => right('dummyLocationKey'),
  );
  when(mockWeatherRepo.loadCurrentConditions(any)).thenAnswer(
    (_) async => right(_dummyWeatherConditions),
  );

  blocTest(
    'The cubit should emit WeatherLoading, WeatherDataLoaded on initialization',
    build: () => WeatherCubit(
      weatherRepo: mockWeatherRepo,
      locationRepo: mockLocationRepo,
    ),
    expect: () => [
      WeatherLoading(),
      WeatherDataLoaded(_dummyWeatherConditions),
    ],
  );
}

final _dummyWeatherConditions = WeatherCurrentConditions(
  icon: 5,
  regularTemperature: 20,
  realFeelTemperature: 19.5,
  windSpeed: 5,
  uvIndexText: 'Moderate',
);
