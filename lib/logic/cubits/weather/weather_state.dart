part of 'weather_cubit.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherDataLoaded extends WeatherState {
  final WeatherCurrentConditions currentConditions;

  const WeatherDataLoaded(this.currentConditions);

  @override
  List<Object> get props => [currentConditions];
}

final class WeatherDataError extends WeatherState {
  final GeneralError error;

  const WeatherDataError(this.error);

  @override
  List<Object> get props => [error];
}
