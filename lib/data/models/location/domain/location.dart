import 'package:geolocator/geolocator.dart';

class Location {
  final double lat;
  final double lon;

  Location({
    required this.lat,
    required this.lon,
  });

  factory Location.fromPosition(Position position) => Location(
        lat: position.latitude,
        lon: position.longitude,
      );
}
