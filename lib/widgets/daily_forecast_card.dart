import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import '../utils/date_formatter.dart';
import '../utils/constants.dart';

class DailyForecastCard extends StatelessWidget {
  final ForecastModel forecast;

  const DailyForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final weatherService = WeatherService();

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: kScreenPadding,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(kCardBorderRadius / 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              DateFormatter.formatDayOfWeek(forecast.dateTime),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          CachedNetworkImage(
            imageUrl: weatherService.getIconUrl(forecast.icon),
            height: 30,
            width: 30,
            color: Colors.white,
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                forecast.description,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
          
          Text(
            '${forecast.tempMax.round()}°/${forecast.tempMin.round()}°',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${(forecast.precipitationProb! * 100).round()}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}