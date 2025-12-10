import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/models/weather_model.dart';

void main() {
  group('WeatherModel Tests', () {
    test('Should parse JSON correctly', () {
      final json = {
        'name': 'Ho Chi Minh City',
        'sys': {'country': 'VN'},
        'main': {
          'temp': 30.15,
          'feels_like': 35.42,
          'humidity': 74,
          'pressure': 1009,
          'temp_min': 29.44,
          'temp_max': 31.0,
        },
        'wind': {'speed': 3.6},
        'weather': [
          {
            'description': 'few clouds',
            'icon': '02d',
            'main': 'Clouds',
          }
        ],
        'dt': 1701752400,
        'visibility': 10000,
        'clouds': {'all': 20},
        'sys': {
          'country': 'VN',
          'sunrise': 1701723165,
          'sunset': 1701765400,
        },
      };

      final weather = WeatherModel.fromJson(json);

      expect(weather.cityName, equals('Ho Chi Minh City'));
      expect(weather.country, equals('VN'));
      expect(weather.temperature, equals(30.15));
      expect(weather.feelsLike, equals(35.42));
      expect(weather.humidity, equals(74));
      expect(weather.windSpeed, equals(3.6));
      expect(weather.pressure, equals(1009));
      expect(weather.description, equals('few clouds'));
      expect(weather.icon, equals('02d'));
      expect(weather.mainCondition, equals('Clouds'));
      expect(weather.tempMin, equals(29.44));
      expect(weather.tempMax, equals(31.0));
      expect(weather.visibility, equals(10000));
      expect(weather.cloudiness, equals(20));
      expect(weather.sunrise.millisecondsSinceEpoch, equals(1701723165 * 1000));
      expect(weather.sunset.millisecondsSinceEpoch, equals(1701765400 * 1000));
    });

    test('Should handle missing optional fields', () {
      final json = {
        'name': 'Test City',
        'sys': {'country': 'US'},
        'main': {
          'temp': 20.0,
          'feels_like': 22.0,
          'humidity': 50,
          'pressure': 1013,
        },
        'wind': {'speed': 5.0},
        'weather': [
          {
            'description': 'clear sky',
            'icon': '01d',
            'main': 'Clear',
          }
        ],
        'dt': 1701752400,
        'sys': {
          'country': 'US',
          'sunrise': 1701723165,
          'sunset': 1701765400,
        },
      };

      final weather = WeatherModel.fromJson(json);

      expect(weather.visibility, isNull);
      expect(weather.cloudiness, isNull);
      expect(weather.tempMin, isNull);
      expect(weather.tempMax, isNull);
    });

    test('Should convert to JSON correctly', () {
      final weather = WeatherModel(
        cityName: 'Test City',
        country: 'US',
        temperature: 25.0,
        feelsLike: 27.0,
        humidity: 60,
        windSpeed: 10.0,
        pressure: 1013,
        description: 'sunny',
        icon: '01d',
        mainCondition: 'Clear',
        dateTime: DateTime.fromMillisecondsSinceEpoch(1701752400 * 1000),
        sunrise: DateTime.fromMillisecondsSinceEpoch(1701723165 * 1000),
        sunset: DateTime.fromMillisecondsSinceEpoch(1701765400 * 1000),
      );

      final json = weather.toJson();

      expect(json['name'], equals('Test City'));
      expect(json['sys']['country'], equals('US'));
      expect(json['main']['temp'], equals(25.0));
      expect(json['weather'][0]['description'], equals('sunny'));
    });

    test('Should handle different weather conditions', () {
      final json = {
        'name': 'Test City',
        'sys': {'country': 'US'},
        'main': {
          'temp': 15.0,
          'feels_like': 16.0,
          'humidity': 80,
          'pressure': 1000,
        },
        'wind': {'speed': 8.0},
        'weather': [
          {
            'description': 'heavy rain',
            'icon': '10d',
            'main': 'Rain',
          }
        ],
        'dt': 1701752400,
        'sys': {
          'country': 'US',
          'sunrise': 1701723165,
          'sunset': 1701765400,
        },
      };

      final weather = WeatherModel.fromJson(json);

      expect(weather.mainCondition, equals('Rain'));
      expect(weather.description, equals('heavy rain'));
      expect(weather.icon, equals('10d'));
    });
  });
}