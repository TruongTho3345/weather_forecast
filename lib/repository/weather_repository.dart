import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/constant/api_constants.dart';
import 'package:weather_forecast/model/weather_model.dart';

class WeatherRepository {
  Future<WeatherData> fetchWeatherData(double lat, double lon) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=${ApiConstants.apiOpenWeather}&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return WeatherData.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

class HourlyRepository {
  Future<HourlyData> fetchHourlyForecast(double lat, double lon) async {
    final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&hourly=temperature_2m,weather_code&timezone=auto&forecast_days=1');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['hourly'] != null) {
        return HourlyData.fromJson(jsonResponse['hourly']);
      } else {
        throw Exception('Hourly data is null');
      }
    } else {
      throw Exception('Failed to load hourly data');
    }
  }
}
