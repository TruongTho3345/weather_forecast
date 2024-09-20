import 'package:weather_forecast/model/weather_model.dart';
import 'package:weather_forecast/repository/weather_repository.dart';

class WeatherApiService {
  final WeatherRepository _weatherRepository = WeatherRepository();

  Future<WeatherData> getWeatherData(double lat, double lon) {
    return _weatherRepository.fetchWeatherData(lat, lon);
  }
}

class HourlyForecastService {
  final HourlyRepository _hourlyRepository = HourlyRepository();

  Future<HourlyData> getHourlyData(double lat, double lon) {
    return _hourlyRepository.fetchHourlyForecast(lat, lon);
  }
}
