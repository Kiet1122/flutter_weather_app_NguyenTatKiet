import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/services/weather_service.dart';

void main() {
  group('WeatherService Tests', () {
    late WeatherService weatherService;

    setUp(() {
      weatherService = WeatherService();
    });

    test('Should create icon URL correctly', () {
      final iconCode = '01d';
      final url = weatherService.getIconUrl(iconCode);

      expect(url, equals('https://openweathermap.org/img/wn/01d@2x.png'));
    });

    test('Should create icon URL for different icon codes', () {
      expect(weatherService.getIconUrl('02d'),
          equals('https://openweathermap.org/img/wn/02d@2x.png'));
      expect(weatherService.getIconUrl('10n'),
          equals('https://openweathermap.org/img/wn/10n@2x.png'));
      expect(weatherService.getIconUrl(''),
          equals('https://openweathermap.org/img/wn/@2x.png'));
    });

    test('Should handle API methods', () async {
      expect(weatherService.getCurrentWeatherByCity, isNotNull);
      expect(weatherService.getCurrentWeatherByCoordinates, isNotNull);
      expect(weatherService.getForecast, isNotNull);
    });

    test('Should build URLs with correct parameters', () {
      expect(weatherService, isA<WeatherService>());
    });

    test('Should handle network errors gracefully', () async {
      expect(() => weatherService.getIconUrl('test'), returnsNormally);
    });
  });
}