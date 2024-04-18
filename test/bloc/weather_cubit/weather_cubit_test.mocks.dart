// Mocks generated by Mockito 5.4.4 from annotations
// in task_manager_app/test/bloc/weather_cubit/weather_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:task_manager_app/data/models/general_error/domain/general_error.dart'
    as _i5;
import 'package:task_manager_app/data/models/location/domain/location.dart'
    as _i6;
import 'package:task_manager_app/data/models/weather_current_conditions/domain/weather_current_conditions.dart'
    as _i7;
import 'package:task_manager_app/data/repositories/location_repository.dart'
    as _i8;
import 'package:task_manager_app/data/repositories/weather_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i3.WeatherRepository {
  @override
  _i4.Future<_i2.Either<_i5.GeneralError, String>> findLocationKeyByGeoposition(
          _i6.Location? location) =>
      (super.noSuchMethod(
        Invocation.method(
          #findLocationKeyByGeoposition,
          [location],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.GeneralError, String>>.value(
            _FakeEither_0<_i5.GeneralError, String>(
          this,
          Invocation.method(
            #findLocationKeyByGeoposition,
            [location],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.GeneralError, String>>.value(
                _FakeEither_0<_i5.GeneralError, String>(
          this,
          Invocation.method(
            #findLocationKeyByGeoposition,
            [location],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.GeneralError, String>>);

  @override
  _i4.Future<_i2.Either<_i5.GeneralError, _i7.WeatherCurrentConditions>>
      loadCurrentConditions(String? locationKey) => (super.noSuchMethod(
            Invocation.method(
              #loadCurrentConditions,
              [locationKey],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.GeneralError,
                        _i7.WeatherCurrentConditions>>.value(
                _FakeEither_0<_i5.GeneralError, _i7.WeatherCurrentConditions>(
              this,
              Invocation.method(
                #loadCurrentConditions,
                [locationKey],
              ),
            )),
            returnValueForMissingStub: _i4.Future<
                    _i2.Either<_i5.GeneralError,
                        _i7.WeatherCurrentConditions>>.value(
                _FakeEither_0<_i5.GeneralError, _i7.WeatherCurrentConditions>(
              this,
              Invocation.method(
                #loadCurrentConditions,
                [locationKey],
              ),
            )),
          ) as _i4.Future<
              _i2.Either<_i5.GeneralError, _i7.WeatherCurrentConditions>>);
}

/// A class which mocks [LocationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocationRepository extends _i1.Mock
    implements _i8.LocationRepository {
  @override
  _i4.Future<void> askLocationPermissions() => (super.noSuchMethod(
        Invocation.method(
          #askLocationPermissions,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<_i2.Either<_i5.GeneralError, _i6.Location>> obtainUserLocation() =>
      (super.noSuchMethod(
        Invocation.method(
          #obtainUserLocation,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.GeneralError, _i6.Location>>.value(
                _FakeEither_0<_i5.GeneralError, _i6.Location>(
          this,
          Invocation.method(
            #obtainUserLocation,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.GeneralError, _i6.Location>>.value(
                _FakeEither_0<_i5.GeneralError, _i6.Location>(
          this,
          Invocation.method(
            #obtainUserLocation,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.GeneralError, _i6.Location>>);
}
