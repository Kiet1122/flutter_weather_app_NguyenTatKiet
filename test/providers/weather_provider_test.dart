import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weatherapp/providers/weather_provider.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/models/forecast_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/services/location_service.dart';
import 'package:weatherapp/services/storage_service.dart';
import 'package:weatherapp/services/connectivity_service.dart';

class SimpleWeatherService extends WeatherService {
  @override
  Future<WeatherModel> getCurrentWeatherByCity(String cityName) async {
    await Future.delayed(const Duration(milliseconds: 10));
    if (cityName == 'ErrorCity') {
      throw Exception('City not found');
    }
    return WeatherModel(
      cityName: cityName,
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
  }

  @override
  Future<WeatherModel> getCurrentWeatherByCoordinates(double lat, double lon) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return WeatherModel(
      cityName: 'Current Location',
      country: 'US',
      temperature: 22.0,
      feelsLike: 24.0,
      humidity: 65,
      windSpeed: 8.0,
      pressure: 1015,
      description: 'partly cloudy',
      icon: '02d',
      mainCondition: 'Clouds',
      dateTime: DateTime.now(),
      sunrise: DateTime.now(),
      sunset: DateTime.now(),
    );
  }

  @override
  Future<List<ForecastModel>> getForecast(String cityName) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return [
      ForecastModel(
        dateTime: DateTime.now().add(const Duration(hours: 3)),
        temperature: 26.0,
        description: 'clear',
        icon: '01d',
        tempMin: 24.0,
        tempMax: 28.0,
        humidity: 55,
        windSpeed: 12.0,
        precipitationProb: 0.1,
      ),
    ];
  }

  @override
  String getIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}

class SimpleLocationService extends LocationService {
  @override
  Future<bool> checkPermission() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  Future<String> getCityName(double lat, double lon) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return 'Test City';
  }

  @override
  Future<Position> getCurrentLocation() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return Position(
      latitude: 10.8231,
      longitude: 106.6297,
      timestamp: DateTime.now(),
      altitude: 0.0,
      accuracy: 10.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 0.0,
      headingAccuracy: 0.0,
    );
  }
}

class SimpleStorageService extends StorageService {
  final Map<String, dynamic> _storage = {};
  WeatherModel? _cachedWeather;

  @override
  Future<void> saveWeatherData(WeatherModel weather) async {
    await Future.delayed(const Duration(milliseconds: 10));
    _cachedWeather = weather;
  }

  @override
  Future<WeatherModel?> getCachedWeather() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return _cachedWeather;
  }

  @override
  Future<bool> isCacheValid() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return _cachedWeather != null;
  }

  @override
  Future<void> saveFavoriteCities(List<String> cities) async {
    await Future.delayed(const Duration(milliseconds: 10));
    _storage['favorites'] = cities;
  }

  @override
  Future<List<String>> getFavoriteCities() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return (_storage['favorites'] as List?)?.cast<String>() ?? [];
  }
}

class MockConnectivityService implements ConnectivityService {
  @override
  Future<bool> isConnected() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return [ConnectivityResult.wifi];
  }

  @override
  Stream<List<ConnectivityResult>> get connectivityStream {
    return Stream.value([ConnectivityResult.wifi]);
  }

  @override
  void dispose() {
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeatherProvider Tests', () {
    late WeatherProvider provider;
    late SimpleWeatherService weatherService;
    late SimpleLocationService locationService;
    late SimpleStorageService storageService;
    late MockConnectivityService connectivityService;

    setUp(() {
      weatherService = SimpleWeatherService();
      locationService = SimpleLocationService();
      storageService = SimpleStorageService();
      connectivityService = MockConnectivityService();
      
      provider = WeatherProvider(
        weatherService,
        locationService,
        storageService,
        connectivityService,
      );
    });

    test('Initial state should be initial', () {
      expect(provider.state, equals(WeatherState.initial));
      expect(provider.currentWeather, isNull);
      expect(provider.forecast, isEmpty);
      expect(provider.errorMessage, isEmpty);
    });

    test('Should fetch weather by city successfully', () async {
      await provider.fetchWeatherByCity('London');
      
      expect(provider.state, equals(WeatherState.loaded));
      expect(provider.currentWeather, isNotNull);
      expect(provider.currentWeather?.cityName, equals('London'));
      expect(provider.forecast, isNotEmpty);
      expect(provider.errorMessage, isEmpty);
    });

    test('Should handle error when fetching invalid city', () async {
      await provider.fetchWeatherByCity('ErrorCity');
      
      expect(provider.state, equals(WeatherState.error));
      expect(provider.currentWeather, isNull);
      expect(provider.errorMessage, contains('City not found'));
    });

    test('Should fetch weather by location successfully', () async {
      await provider.fetchWeatherByLocation();
      
      expect(provider.state, equals(WeatherState.loaded));
      expect(provider.currentWeather, isNotNull);
      expect(provider.currentWeather?.cityName, equals('Current Location'));
      expect(provider.forecast, isNotEmpty);
    });

    test('Should load cached weather', () async {
      final testWeather = WeatherModel(
        cityName: 'Cached City',
        country: 'US',
        temperature: 20.0,
        feelsLike: 21.0,
        humidity: 60,
        windSpeed: 3.0,
        pressure: 1015,
        description: 'sunny',
        icon: '01d',
        mainCondition: 'Clear',
        dateTime: DateTime.now(),
        sunrise: DateTime.now(),
        sunset: DateTime.now(),
      );
      
      await storageService.saveWeatherData(testWeather);
      await provider.loadCachedWeather();
      
      expect(provider.state, equals(WeatherState.loaded));
      expect(provider.currentWeather?.cityName, equals('Cached City'));
    });

    test('Should handle empty cache gracefully', () async {
      await provider.loadCachedWeather();
      
      expect(provider.state, equals(WeatherState.initial));
      expect(provider.currentWeather, isNull);
    });

    test('Should refresh weather', () async {
      await provider.fetchWeatherByCity('Paris');
      final initialWeather = provider.currentWeather;
      
      await provider.refreshWeather();
      
      expect(provider.state, equals(WeatherState.loaded));
      expect(provider.currentWeather, isNotNull);
      expect(initialWeather, isNotNull);
      expect(provider.currentWeather, isNotNull);
    });

    test('Should have correct getters', () {
      expect(provider.currentWeather, isNull);
      expect(provider.forecast, isEmpty);
      expect(provider.state, equals(WeatherState.initial));
      expect(provider.errorMessage, isEmpty);
    });

    test('Should change state correctly during operations', () async {
      final future = provider.fetchWeatherByCity('Berlin');
      
      expect(provider.state, equals(WeatherState.loading));
      
      await future;
      
      expect(provider.state, equals(WeatherState.loaded));
    });
  });
}