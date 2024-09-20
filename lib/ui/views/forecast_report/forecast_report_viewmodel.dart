import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_forecast/model/weather_model.dart';
import 'package:weather_forecast/services/weather_api_service.dart';

class ForecastReportViewModel extends BaseViewModel {
  final WeatherApiService _weatherService = WeatherApiService();
  final HourlyForecastService _hourlyService = HourlyForecastService();

  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  HourlyData? _hourlyData;

  HourlyData? get hourlyData => _hourlyData;

  Future<void> fetchForecastReport(double lat, double lon) async {
    setBusy(true);
    await fetchDailyForecast(lat, lon);
    await fetchHourlyForecast(lat, lon);
    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchDailyForecast(double lat, double lon) async {
    setBusy(true);
    try {
      _weatherData = await _weatherService.getWeatherData(lat, lon);
    } catch (e) {
      debugPrint('Error fetching daily forecast: $e');
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchHourlyForecast(double lat, double lon) async {
    setBusy(true);
    try {
      _hourlyData = await _hourlyService.getHourlyData(lat, lon);
    } catch (e) {
      debugPrint('Error fetching hourly forecast: $e');
    }
    setBusy(false);
    notifyListeners();
  }

  String formatTimeFromDt(int dt) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return "${dateTime.hour.toString().padLeft(2, '0')}.${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String formatTimeFromString(String timeString) {
    DateTime parsedTime = DateTime.parse(timeString);
    return '${parsedTime.hour}.00';
  }

  String formatDateFromDt(int dt) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return DateFormat('MMM, d').format(dateTime);
  }
}
