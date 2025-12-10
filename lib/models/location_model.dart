class LocationModel {
  final double latitude;
  final double longitude;
  final String cityName;
  final String? country; 

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.cityName,
    this.country,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'lon': longitude,
      'city_name': cityName,
      'country': country,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lon'] as num).toDouble(),
      cityName: json['city_name'] as String,
      country: json['country'] as String?,
    );
  }

  @override
  String toString() {
    return '$cityName ($latitude, $longitude)';
  }
}