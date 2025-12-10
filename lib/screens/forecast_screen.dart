import 'package:flutter/material.dart';
import '../models/forecast_model.dart';

class ForecastScreen extends StatelessWidget {
  final List<ForecastModel> fullForecast; 

  const ForecastScreen({super.key, required this.fullForecast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full 5-Day Forecast'),
      ),
      body: ListView.builder(
        itemCount: fullForecast.length,
        itemBuilder: (context, index) {
          final forecast = fullForecast[index];
          return ListTile(
            leading: const Icon(Icons.wb_cloudy),
            title: Text(forecast.description),
            subtitle: Text('${forecast.temperature.round()}°C - Wind: ${forecast.windSpeed} m/s'),
            trailing: Text('Time: ${forecast.dateTime.hour}:00'),
          );
        },
      ),
    );
  }
}