import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/services/storage_service.dart';
import 'package:weatherapp/models/weather_model.dart';

void main() {
  group('StorageService Tests', () {
    late StorageService storageService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      storageService = StorageService();
    });

    test('Should save and retrieve favorite cities', () async {
      final testCities = ['London', 'Paris', 'Tokyo', 'New York', 'Sydney'];

      await storageService.saveFavoriteCities(testCities);
      final retrievedCities = await storageService.getFavoriteCities();

      expect(retrievedCities, equals(testCities));
    });

    test('Should return empty list when no favorite cities', () async {
      final cities = await storageService.getFavoriteCities();
      expect(cities, isEmpty);
    });

    test('Should handle empty favorite cities list', () async {
      await storageService.saveFavoriteCities([]);
      final cities = await storageService.getFavoriteCities();
      expect(cities, isEmpty);
    });

    test('Should save single favorite city', () async {
      await storageService.saveFavoriteCities(['London']);
      final cities = await storageService.getFavoriteCities();
      expect(cities, equals(['London']));
    });

    test('Should overwrite existing favorite cities', () async {
      await storageService.saveFavoriteCities(['London', 'Paris']);
      await storageService.saveFavoriteCities(['Tokyo', 'Sydney']);
      final cities = await storageService.getFavoriteCities();
      expect(cities, equals(['Tokyo', 'Sydney']));
    });

    test('Should return valid cache status', () async {
      final isValid = await storageService.isCacheValid();
      expect(isValid, isFalse);
    });

    test('Should save weather data', () async {
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
        dateTime: DateTime.now(),
        sunrise: DateTime.now(),
        sunset: DateTime.now(),
      );

      expect(() async => await storageService.saveWeatherData(weather),
          returnsNormally);
    });

    test('Should return null when no cached weather', () async {
      final cachedWeather = await storageService.getCachedWeather();
      expect(cachedWeather, isNull);
    });

    test('Should handle large number of favorite cities', () async {
      final manyCities = List.generate(20, (index) => 'City $index');
      await storageService.saveFavoriteCities(manyCities);
      final cities = await storageService.getFavoriteCities();
      expect(cities.length, equals(20));
    });
  });
}