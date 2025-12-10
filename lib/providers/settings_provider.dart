import 'package:flutter/material.dart';
import '../services/language_service.dart';

enum TemperatureUnit { celsius, fahrenheit }
enum WindSpeedUnit { ms, kmh, mph }

class SettingsProvider extends ChangeNotifier {
  TemperatureUnit _temperatureUnit = TemperatureUnit.celsius;
  TemperatureUnit get temperatureUnit => _temperatureUnit;
  
  WindSpeedUnit _windSpeedUnit = WindSpeedUnit.ms;
  WindSpeedUnit get windSpeedUnit => _windSpeedUnit;
  
  bool _is24HourFormat = true;
  bool get is24HourFormat => _is24HourFormat;
  
  AppLanguage _language = AppLanguage.english;
  AppLanguage get language => _language;
  
  void setTemperatureUnit(TemperatureUnit unit) {
    _temperatureUnit = unit;
    notifyListeners();
  }
  
  void setWindSpeedUnit(WindSpeedUnit unit) {
    _windSpeedUnit = unit;
    notifyListeners();
  }
  
  void set24HourFormat(bool value) {
    _is24HourFormat = value;
    notifyListeners();
  }
  
  void setLanguage(AppLanguage lang) {
    _language = lang;
    notifyListeners();
  }
  
  String formatTemperature(double tempCelsius) {
    switch (_temperatureUnit) {
      case TemperatureUnit.celsius:
        return '${tempCelsius.round()}°C';
      case TemperatureUnit.fahrenheit:
        final tempF = (tempCelsius * 9/5) + 32;
        return '${tempF.round()}°F';
    }
  }
  
  String formatWindSpeed(double speedMs) {
    switch (_windSpeedUnit) {
      case WindSpeedUnit.ms:
        return '${speedMs.toStringAsFixed(1)} m/s';
      case WindSpeedUnit.kmh:
        final speedKmh = speedMs * 3.6;
        return '${speedKmh.toStringAsFixed(1)} km/h';
      case WindSpeedUnit.mph:
        final speedMph = speedMs * 2.237;
        return '${speedMph.toStringAsFixed(1)} mph';
    }
  }
  
  String translate(String key) {
    return LanguageService.translate(key, _language.code);
  }
}