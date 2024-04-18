import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/weather_current_conditions/domain/weather_current_conditions.dart';
import '../../../../../../logic/cubits/weather/weather_cubit.dart';
import '../../../../../common/dimensions.dart';
import '../../../../../common/ui/weather_color_helper.dart';
import '../../../../../common/ui/weather_icon.dart';

class CurrentWeatherConditionsSection extends StatelessWidget {
  const CurrentWeatherConditionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (context, opacity, child) => Opacity(
        opacity: opacity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingL),
          child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              final data = (state as WeatherDataLoaded).currentConditions;

              return CardWrapper(
                borderColor: WeatherColorHelper.obtainColor(data.icon),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingS),
                  child: Row(
                    children: [
                      WheaterIcon.big(value: data.icon),
                      CurrentConditionsInfo(data),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CurrentConditionsInfo extends StatelessWidget {
  final WeatherCurrentConditions currentConditions;

  const CurrentConditionsInfo(this.currentConditions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: Dimensions.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Temperature: ${currentConditions.regularTemperature}°C',
          ),
          Text(
            'Wind: ${currentConditions.windSpeed} km/h',
          ),
          Text('Real Feel: ${currentConditions.realFeelTemperature}°C'),
          Text('UVIndex: ${currentConditions.uvIndexText}'),
        ],
      ),
    );
  }
}

class CardWrapper extends StatelessWidget {
  final Widget child;
  final Color borderColor;

  const CardWrapper({
    required this.child,
    required this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: Dimensions.paddingL,
          end: Dimensions.paddingL,
          top: Dimensions.paddingL,
          bottom: Dimensions.paddingS,
        ),
        child: child,
      ),
    );
  }
}
