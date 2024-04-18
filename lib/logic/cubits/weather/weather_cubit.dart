import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager_app/data/common/statics.dart';
import 'package:task_manager_app/data/models/general_error/domain/general_error.dart';
import 'package:task_manager_app/data/models/location/domain/location.dart';
import 'package:task_manager_app/data/models/weather_current_conditions/domain/weather_current_conditions.dart';
import 'package:task_manager_app/data/repositories/location_repository.dart';
import 'package:task_manager_app/data/repositories/weather_repository.dart';

part 'weather_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepo;
  final LocationRepository _locationRepo;
  late Location location;

  WeatherCubit({
    required WeatherRepository weatherRepo,
    required LocationRepository locationRepo,
  })  : _weatherRepo = weatherRepo,
        _locationRepo = locationRepo,
        super(WeatherInitial()) {
    _onStartup();
  }

  void _onStartup() async {
    await _obtainLocation();
    await _fetchWeatherConditions();
  }

  Future<void> _obtainLocation() async {
    await _locationRepo.askLocationPermissions();
    final response = await _locationRepo.obtainUserLocation();

    response.fold(
      (error) => location = Statics.defaultLocation,
      (userLocation) => location = userLocation,
    );
  }

  Future<void> _fetchWeatherConditions() async {
    emit(WeatherLoading());

    final response = await _weatherRepo.findLocationKeyByGeoposition(location);

    response.fold(
      (error) => emit(WeatherDataError(error)),
      (locationKey) async {
        final response = await _weatherRepo.loadCurrentConditions(locationKey);

        response.fold(
          (error) => emit(WeatherDataError(error)),
          (currentConditions) => emit(
            WeatherDataLoaded(currentConditions),
          ),
        );
      },
    );
  }
}
