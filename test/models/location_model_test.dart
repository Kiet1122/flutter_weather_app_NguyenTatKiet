import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/models/location_model.dart';

void main() {
  group('LocationModel Tests', () {
    test('Should create model correctly', () {
      final location = LocationModel(
        latitude: 10.8231,
        longitude: 106.6297,
        cityName: 'Ho Chi Minh City',
        country: 'VN',
      );

      expect(location.latitude, equals(10.8231));
      expect(location.longitude, equals(106.6297));
      expect(location.cityName, equals('Ho Chi Minh City'));
      expect(location.country, equals('VN'));
    });

    test('Should handle null country', () {
      final location = LocationModel(
        latitude: 10.8231,
        longitude: 106.6297,
        cityName: 'Ho Chi Minh City',
        country: null,
      );

      expect(location.country, isNull);
    });

    test('Should convert to JSON correctly', () {
      final location = LocationModel(
        latitude: 10.8231,
        longitude: 106.6297,
        cityName: 'Ho Chi Minh City',
        country: 'VN',
      );

      final json = location.toJson();

      expect(json['lat'], equals(10.8231));
      expect(json['lon'], equals(106.6297));
      expect(json['city_name'], equals('Ho Chi Minh City'));
      expect(json['country'], equals('VN'));
    });

    test('Should parse from JSON correctly', () {
      final json = {
        'lat': 10.8231,
        'lon': 106.6297,
        'city_name': 'Ho Chi Minh City',
        'country': 'VN',
      };

      final location = LocationModel.fromJson(json);

      expect(location.latitude, equals(10.8231));
      expect(location.longitude, equals(106.6297));
      expect(location.cityName, equals('Ho Chi Minh City'));
      expect(location.country, equals('VN'));
    });

    test('Should handle JSON without country', () {
      final json = {
        'lat': 10.8231,
        'lon': 106.6297,
        'city_name': 'Ho Chi Minh City',
      };

      final location = LocationModel.fromJson(json);

      expect(location.country, isNull);
    });

    test('Should have correct string representation', () {
      final location = LocationModel(
        latitude: 10.8231,
        longitude: 106.6297,
        cityName: 'Ho Chi Minh City',
        country: 'VN',
      );

      expect(location.toString(),
          equals('Ho Chi Minh City (10.8231, 106.6297)'));
    });
  });
}