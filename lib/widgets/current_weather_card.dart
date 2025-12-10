import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/weather_model.dart';
import '../utils/date_formatter.dart';
import '../services/weather_service.dart';
import '../providers/settings_provider.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;
  
  final WeatherService _weatherService = WeatherService();
  
  CurrentWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final iconUrl = _weatherService.getIconUrl(weather.icon).replaceFirst('@2x', '@4x');

    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                '${weather.cityName}, ${weather.country}',
                style: const TextStyle(
                  fontSize: 32, 
                  color: Colors.white, 
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                DateFormatter.formatFullDate(weather.dateTime),
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              
              CachedNetworkImage(
                imageUrl: iconUrl,
                height: 120,
                width: 120,
                placeholder: (context, url) => 
                  const CircularProgressIndicator(color: Colors.white),
                errorWidget: (context, url, error) => 
                  const Icon(Icons.cloud_off, color: Colors.white, size: 80),
              ),
              
              Text(
                settings.formatTemperature(weather.temperature),
                style: const TextStyle(
                  fontSize: 80, 
                  color: Colors.white, 
                  fontWeight: FontWeight.w200,
                ),
              ),
              
              Text(
                weather.description.toUpperCase(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              
              Text(
                'Feels like ${settings.formatTemperature(weather.feelsLike)}',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        );
      },
    );
  }
}