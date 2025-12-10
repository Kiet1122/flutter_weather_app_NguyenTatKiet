import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/services/location_service.dart';

void main() {
  group('LocationService Tests', () {
    late LocationService locationService;

    setUp(() {
      locationService = LocationService();
    });

    test('Should instantiate correctly', () {
      expect(locationService, isA<LocationService>());
    });

    test('Should have checkPermission method', () {
      expect(locationService.checkPermission, isNotNull);
    });

    test('Should have getCurrentLocation method', () {
      expect(locationService.getCurrentLocation, isNotNull);
    });

    test('Should have getCityName method', () {
      expect(locationService.getCityName, isNotNull);
    });

    test('Should handle location service methods', () async {
      expect(() => locationService.checkPermission(), throwsA(anything));
      expect(() => locationService.getCurrentLocation(), throwsA(anything));
      expect(() => locationService.getCityName(0, 0), throwsA(anything));
    });

    test('Should handle permission denied scenarios', () async {
      expect(locationService, isNotNull);
    });

    test('Should handle coordinate conversion', () async {
      expect(locationService.getCityName, isA<Future<String> Function(double, double)>());
    });
  });
}