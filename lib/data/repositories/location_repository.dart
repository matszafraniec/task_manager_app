import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager_app/data/models/location/domain/location.dart';

import '../models/general_error/domain/general_error.dart';

abstract class LocationRepository {
  Future<void> askLocationPermissions();
  Future<Either<GeneralError, Location>> obtainUserLocation();
}

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends LocationRepository {
  LocationRepositoryImpl();

  @override
  Future<Either<GeneralError, Location>> obtainUserLocation() async {
    final locationPermission = await Geolocator.checkPermission();

    final hasPermissionsGranted =
        await isLocationAccessible(locationPermission);

    if (hasPermissionsGranted) {
      final lastKnownPosition = await Geolocator.getLastKnownPosition();

      if (lastKnownPosition != null) {
        return right(Location.fromPosition(lastKnownPosition));
      } else {
        final currentPosition = await Geolocator.getCurrentPosition();

        return right(Location.fromPosition(currentPosition));
      }
    }

    return left(GeneralError.unexpected());
  }

  @override
  Future<void> askLocationPermissions() async {
    await Geolocator.requestPermission();
  }

  Future<bool> isLocationAccessible(LocationPermission permisson) async {
    return permisson == LocationPermission.always &&
            await Geolocator.isLocationServiceEnabled() ||
        permisson == LocationPermission.whileInUse &&
            await Geolocator.isLocationServiceEnabled();
  }
}
