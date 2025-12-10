import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import '../utils/date_formatter.dart';
import '../utils/constants.dart';
import '../providers/settings_provider.dart';

class HourlyForecastList extends StatelessWidget {
  final List<ForecastModel> forecasts;

  const HourlyForecastList({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    final hourlyItems = forecasts.take(8).toList(); 
    final weatherService = WeatherService();

    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Padding(
          padding: const EdgeInsets.only(left: kScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: kScreenPadding, bottom: 8),
                child: Text(
                  'HOURLY FORECAST',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hourlyItems.length,
                  itemBuilder: (context, index) {
                    final item = hourlyItems[index];
                    return _buildHourlyItem(
                      context, 
                      item, 
                      weatherService, 
                      settings,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHourlyItem(
    BuildContext context, 
    ForecastModel item, 
    WeatherService service,
    SettingsProvider settings,
  ) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(kCardBorderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            DateFormatter.formatHourOnly(
              item.dateTime, 
              is24HourFormat: settings.is24HourFormat,
            ),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          
          CachedNetworkImage(
            imageUrl: service.getIconUrl(item.icon),
            height: 40,
            width: 40,
            color: Colors.white,
          ),
          
          Text(
            settings.formatTemperature(item.temperature),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}