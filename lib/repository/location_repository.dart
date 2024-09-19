import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/model/location_model.dart';
import 'package:weather_forecast/services/location_service.dart';

class LocationRepository {
  final LocationService _locationService = LocationService();

  Future<List<LocationModel>> searchLocation(String locationName) {
    return _locationService.getLocationCoordinates(locationName);
  }

  Future<Position> getCurrentPosition() {
    return _locationService.getCurrentPosition();
  }
}
