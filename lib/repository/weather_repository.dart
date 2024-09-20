import 'package:weather_forecast/services/weather_api_service.dart';
import 'package:weather_forecast/model/weather_model.dart';

class WeatherRepository {
  final WeatherApiService _weatherApiService = WeatherApiService();

  Future<WeatherData> getWeatherData(double lat, double lon) {
    return _weatherApiService.fetchWeatherData(lat, lon);
  }
}

class HourlyRepository {
  final HourlyForecastService _hourlyForecastService = HourlyForecastService();

  Future<HourlyData> getHourlyData(double lat, double lon) {
    return _hourlyForecastService.fetchHourlyForecast(lat, lon);
  }
}
