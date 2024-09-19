import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

extension WeatherIcon on int {
  IconData getWeatherIcon() {
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
    } else if (this >= 800 && this < 900) {
      return Symbols.cloudy; // Clouds
    } else {
      return Symbols.partly_cloudy_day; // Default icon
    }
  }
}
