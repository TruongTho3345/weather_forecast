import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_forecast/model/location_model.dart';
import 'package:weather_forecast/model/weather_model.dart';
import 'package:weather_forecast/services/location_service.dart';
import 'package:weather_forecast/services/weather_api_service.dart';

class HomeViewModel extends BaseViewModel {
  final WeatherApiService _weatherService = WeatherApiService();
  final LocationService _locationService = LocationService();

  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  String? locationName = "Current Location";

  LocationModel? selectedLocation;
  double defaultLat = 10.804457;
  double defaultLng = 106.709315;

  String? errorMessage;

  Future<void> fetchWeather() async {
    setBusy(true);
    try {
      if (selectedLocation == null) {
        final currentPosition = await _locationService.getCurrentPosition();
        _weatherData = await _weatherService.getWeatherData(
          currentPosition.latitude,
          currentPosition.longitude,
        );
      } else {
        _weatherData = await _weatherService.getWeatherData(
          selectedLocation!.geometry.lat,
          selectedLocation!.geometry.lng,
        );
      }
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      debugPrint('Error fetching weather: $e');
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> updateLocationAndFetchWeather(String locationName) async {
    setBusy(true);
    try {
      List<LocationModel> locations =
          await _locationService.searchLocation(locationName);
      if (locations.isNotEmpty) {
        selectedLocation = locations.first;
        this.locationName = selectedLocation!.formatted;
        await fetchWeather();
      }
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      debugPrint('Error updating location: $e');
    }
    setBusy(false);
    notifyListeners();
  }
}
