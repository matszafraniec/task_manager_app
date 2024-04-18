import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/presentation/common/context_extensions.dart';

import '../../../../../logic/cubits/weather/weather_cubit.dart';
import 'widgets/current_weather_conditions_section.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: _handleSideEffects,
      builder: (context, state) {
        if (state is WeatherInitial || state is WeatherLoading) {
          return const CircularProgressIndicator();
        } else if (state is WeatherDataLoaded) {
          return const CurrentWeatherConditionsSection();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void _handleSideEffects(BuildContext context, WeatherState state) {
    if (state is WeatherDataError) {
      _snackbarError(context, state.error.message);
    }
  }

  void _snackbarError(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: context.themeColors.error,
          content: Text(message),
        ),
      );
}
