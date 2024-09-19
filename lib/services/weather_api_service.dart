import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/constant/api_constants.dart';
import 'package:weather_forecast/model/weather_model.dart';

class WeatherApiService {
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
