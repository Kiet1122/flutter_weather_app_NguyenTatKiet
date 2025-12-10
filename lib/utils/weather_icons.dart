import 'package:flutter/material.dart';

class WeatherIconUtils {
  static IconData getIconForCondition(String mainCondition) {
    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access; 
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return Icons.blur_on;
      default:
        return Icons.help_outline; 
    }
  }

  static String getLocalIconAsset(String iconCode) {
    return 'assets/icons/default.png'; 
  }

  static String normalizeCondition(String condition) {
    return condition.toLowerCase();
  }
}