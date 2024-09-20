import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'weather_model.freezed.dart';

part 'weather_model.g.dart';

@freezed
class Hourly with _$Hourly {
  const factory Hourly({
    required int dt,
    required double temp,
    required List<Weather> weather,
  }) = _Hourly;

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
}

@freezed
class Daily with _$Daily {
  const factory Daily({
    required int dt,
    required Temp temp,
    required List<Weather> weather,
  }) = _Daily;

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);
}

@freezed
class Temp with _$Temp {
  const factory Temp({
    required double day,
    required double min,
    required double max,
    required double night,
    required double eve,
    required double morn,
  }) = _Temp;

  factory Temp.fromJson(Map<String, dynamic> json) => _$TempFromJson(json);
}

@freezed
class Current with _$Current {
  const factory Current({
    required int dt,
    required int sunrise,
    required int sunset,
    required double temp,
    @JsonKey(name: 'feels_like') required double feelsLike,
    required int pressure,
    required int humidity,
    @JsonKey(name: 'dew_point') required double dewPoint,
    required double uvi,
    required int clouds,
    required int visibility,
    @JsonKey(name: 'wind_speed') required double windSpeed,
    @JsonKey(name: 'wind_deg') required int windDeg,
    required List<Weather> weather,
  }) = _Current;

  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
}

@freezed
class Weather with _$Weather {
  const factory Weather({
    required int id,
    required String main,
    required String description,
    required String icon,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@freezed
class WeatherData with _$WeatherData {
  const factory WeatherData({
    required Current current,
    required List<Hourly> hourly,
    required List<Daily> daily,
  }) = _WeatherData;

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
}

@freezed
class HourlyData with _$HourlyData {
  const factory HourlyData({
    required List<String> time,
    required List<double> temperature2m,
    required List<int> weatherCode,
  }) = _HourlyData;

  factory HourlyData.fromJson(Map<String, dynamic> json) => HourlyData(
        time: List<String>.from(json['time']),
        temperature2m: List<double>.from(json['temperature_2m']),
        weatherCode: List<int>.from(json['weather_code']),
      );
}
