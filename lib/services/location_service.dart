import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/model/location_model.dart';
import 'package:weather_forecast/repository/location_repository.dart';

class LocationService {
  final LocationRepository _locationRepository = LocationRepository();

  Future<List<LocationModel>> searchLocation(String locationName) {
    return _locationRepository.getLocationCoordinates(locationName);
  }

  Future<Position> getCurrentPosition() {
    return _locationRepository.getCurrentPosition();
  }
}
