import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_forecast/model/weather_model.dart';
import 'package:weather_forecast/repository/weather_repository.dart';

class ForecastReportViewModel extends BaseViewModel {
  final WeatherRepository _weatherRepository = WeatherRepository();

  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  String? errorMessage;

  Future<void> fetchForecastReport(double lat, double lon) async {
    setBusy(true);
    try {
      _weatherData = await _weatherRepository.getWeatherData(lat, lon);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      print('Error fetching forecast: $e');
    }
    setBusy(false);
    notifyListeners();
  }

  String formatTimeFromDt(int dt) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return "${dateTime.hour.toString().padLeft(2, '0')}.${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String formatDateFromDt(int dt) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return DateFormat('MMM, d').format(dateTime);
  }
}
