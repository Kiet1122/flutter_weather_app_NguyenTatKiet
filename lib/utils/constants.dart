import 'package:flutter/material.dart';

enum WeatherState { initial, loading, loaded, error }

const double kCardBorderRadius = 20.0;
const double kScreenPadding = 20.0;
const double kCardElevation = 4.0;

const Color kDefaultPrimaryColor = Color(0xFF667EEA);
const Color kDefaultBackgroundColor = Color(0xFF764BA2);

const Map<String, List<Color>> kWeatherGradients = {
  'clear': [Color(0xFFFDB813), Color(0xFF87CEEB)], 
  'rain': [Color(0xFF4A5568), Color(0xFF718096)], 
  'clouds': [Color(0xFFA0AEC0), Color(0xFFCBD5E0)], 
  'night': [Color(0xFF2D3748), Color(0xFF1A202C)], 
};

const String kOpenWeatherIconBaseUrl = 'https://openweathermap.org/img/wn/';

const int kCacheDurationMs = 30 * 60 * 1000;