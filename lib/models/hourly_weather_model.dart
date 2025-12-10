class HourlyWeatherModel {
  final DateTime dateTime;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  HourlyWeatherModel({
    required this.dateTime,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000), 
      temperature: (json['main']['temp'] as num).toDouble(), 
      description: json['weather'][0]['description'] ?? '', 
      icon: json['weather'][0]['icon'] ?? '', 
      humidity: json['main']['humidity'] ?? 0, 
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}