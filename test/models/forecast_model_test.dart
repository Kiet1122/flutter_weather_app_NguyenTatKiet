import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/models/forecast_model.dart';

void main() {
  group('ForecastModel Tests', () {
    test('Should parse JSON correctly', () {
      final json = {
        'dt': 1701752400,
        'main': {
          'temp': 30.15,
          'temp_min': 29.44,
          'temp_max': 31.0,
          'humidity': 74,
        },
        'weather': [
          {'description': 'few clouds', 'icon': '02d'},
        ],
        'wind': {'speed': 3.6},
        'pop': 0.2,
      };

      final forecast = ForecastModel.fromJson(json);

      expect(
        forecast.dateTime.millisecondsSinceEpoch,
        equals(1701752400 * 1000),
      );
      expect(forecast.temperature, equals(30.15));
      expect(forecast.tempMin, equals(29.44));
      expect(forecast.tempMax, equals(31.0));
      expect(forecast.humidity, equals(74));
      expect(forecast.windSpeed, equals(3.6));
      expect(forecast.description, equals('few clouds'));
      expect(forecast.icon, equals('02d'));
      expect(forecast.precipitationProb, equals(0.2));
    });


    test('Should handle missing precipitation probability', () {
      final json = {
        'dt': 1701752400,
        'main': {
          'temp': 25.0,
          'temp_min': 24.0,
          'temp_max': 26.0,
          'humidity': 60,
        },
        'weather': [
          {'description': 'clear sky', 'icon': '01d'},
        ],
        'wind': {'speed': 5.0},
      };

      final forecast = ForecastModel.fromJson(json);

      expect(forecast.precipitationProb, isNull); 
    });

    test('Should handle zero precipitation', () {
      final json = {
        'dt': 1701752400,
        'main': {
          'temp': 25.0,
          'temp_min': 24.0,
          'temp_max': 26.0,
          'humidity': 60,
        },
        'weather': [
          {'description': 'clear sky', 'icon': '01d'},
        ],
        'wind': {'speed': 5.0},
        'pop': 0.0,
      };

      final forecast = ForecastModel.fromJson(json);

      expect(forecast.precipitationProb, equals(0.0));
    });

    test('Should handle different temperature units', () {
      final json = {
        'dt': 1701752400,
        'main': {
          'temp': -5.0,
          'temp_min': -8.0,
          'temp_max': -2.0,
          'humidity': 85,
        },
        'weather': [
          {'description': 'snow', 'icon': '13d'},
        ],
        'wind': {'speed': 15.0},
        'pop': 0.9,
      };

      final forecast = ForecastModel.fromJson(json);

      expect(forecast.temperature, equals(-5.0));
      expect(forecast.tempMin, equals(-8.0));
      expect(forecast.tempMax, equals(-2.0));
      expect(forecast.precipitationProb, equals(0.9));
    });
  });
}
