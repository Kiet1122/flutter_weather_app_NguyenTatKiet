import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/config/api_config.dart';
import 'package:weatherapp/models/forecast_model.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherService {

  Future<WeatherModel> getCurrentWeatherByCity(String cityName) async {
    try {
      final url = ApiConfig.buildUrl(ApiConfig.currentWeather, {'q': cityName});

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<WeatherModel> getCurrentWeatherByCoordinates(
    double lat,
    double lon,
  ) async {
    try {
      final url = ApiConfig.buildUrl(ApiConfig.currentWeather, {
        'lat': lat.toString(),
        'lon': lon.toString(),
      });

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<ForecastModel>> getForecast(String cityName) async {
    try {
      final url = ApiConfig.buildUrl(ApiConfig.forecast, {'q': cityName});

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> forecastList = data['list'];

        return forecastList
            .map((item) => ForecastModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  String getIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
