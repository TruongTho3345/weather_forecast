import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

extension WeatherIcon on int {
  IconData getWeatherIcon() {
    // WMO
    switch (this) {
      case 0:
        return Symbols.sunny; // Clear
      case 1:
      case 2:
      case 3:
        return Symbols.partly_cloudy_day; // Partly cloudy
      case 45:
      case 48:
        return Symbols.foggy; // Fog
      case 51:
      case 53:
      case 55:
        return Symbols.water_drop; // Drizzle
      case 56:
      case 57:
      case 66:
      case 67:
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return Symbols.ac_unit; // Freezing/Snow
      case 61:
      case 63:
      case 65:
      case 80:
      case 81:
      case 82:
        return Symbols.rainy; // Rain
      case 95:
      case 96:
      case 99:
        return Symbols.thunderstorm; // Thunderstorm

      // OpenWeather
      default:
        if (this >= 200 && this < 300) {
          return Symbols.thunderstorm; // Thunderstorm
        } else if (this >= 300 && this < 400) {
          return Symbols.water_drop; // Drizzle
        } else if (this >= 500 && this < 600) {
          return Symbols.rainy; // Rain
        } else if (this >= 600 && this < 700) {
          return Symbols.ac_unit; // Snow
        } else if (this == 800) {
          return Symbols.sunny; // Clear
        } else if (this >= 801 && this <= 804) {
          return Symbols.cloudy; // Clouds
        } else {
          return Symbols.partly_cloudy_day; // Default icon
        }
    }
  }
}
