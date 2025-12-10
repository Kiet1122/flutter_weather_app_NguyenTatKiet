import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/widgets/current_weather_card.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/providers/settings_provider.dart';

void main() {
  group('CurrentWeatherCard Widget Tests', () {
    WeatherModel createTestWeather() {
      return WeatherModel(
        cityName: 'Ho Chi Minh City',
        country: 'VN',
        temperature: 30.15,
        feelsLike: 35.42,
        humidity: 74,
        windSpeed: 3.6,
        pressure: 1009,
        description: 'few clouds',
        icon: '02d',
        mainCondition: 'Clouds',
        dateTime: DateTime(2023, 12, 5, 14, 30),
        sunrise: DateTime(2023, 12, 5, 6, 0),
        sunset: DateTime(2023, 12, 5, 17, 30),
      );
    }

    testWidgets('Should display all weather information',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<SettingsProvider>(
            create: (_) => SettingsProvider(),
            child: Scaffold(
              body: CurrentWeatherCard(weather: createTestWeather()),
            ),
          ),
        ),
      );

      expect(find.text('Ho Chi Minh City, VN'), findsOneWidget);

      expect(find.textContaining('30'), findsWidgets);

      expect(find.text('FEW CLOUDS'), findsOneWidget);

      expect(find.textContaining('Feels like'), findsOneWidget);
    });

    testWidgets('Should handle different temperature values',
        (WidgetTester tester) async {
      final coldWeather = WeatherModel(
        cityName: 'Moscow',
        country: 'RU',
        temperature: -5.0,
        feelsLike: -10.0,
        humidity: 85,
        windSpeed: 15.0,
        pressure: 1020,
        description: 'snow',
        icon: '13d',
        mainCondition: 'Snow',
        dateTime: DateTime.now(),
        sunrise: DateTime.now(),
        sunset: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<SettingsProvider>(
            create: (_) => SettingsProvider(),
            child: Scaffold(
              body: CurrentWeatherCard(weather: coldWeather),
            ),
          ),
        ),
      );

      expect(find.textContaining('-5'), findsWidgets);
      expect(find.textContaining('Feels like -10'), findsOneWidget);
    });
  });
}