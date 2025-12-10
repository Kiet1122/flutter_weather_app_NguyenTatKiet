import 'package:flutter/material.dart';

enum AppLanguage {
  english('en', 'English', 'US'),
  vietnamese('vi', 'Tiếng Việt', 'VN'),
  spanish('es', 'Español', 'ES');

  final String code;
  final String name;
  final String countryCode;

  const AppLanguage(this.code, this.name, this.countryCode);

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}

class LanguageService {
  static const String _languageKey = 'app_language';
  
  static final Map<String, Map<String, String>> _translations = {
    'en': {
      'app_title': 'Weather App',
      'current_weather': 'Current Weather',
      'hourly_forecast': 'Hourly Forecast',
      'daily_forecast': '5-Day Forecast',
      'weather_details': 'Weather Details',
      'humidity': 'Humidity',
      'wind': 'Wind',
      'pressure': 'Pressure',
      'visibility': 'Visibility',
      'sunrise': 'Sunrise',
      'sunset': 'Sunset',
      'feels_like': 'Feels like',
      'search_city': 'Search City',
      'enter_city_name': 'Enter city name',
      'favorite_cities': 'Favorite Cities',
      'recent_searches': 'Recent Searches',
      'settings': 'Settings',
      'temperature_unit': 'Temperature Unit',
      'wind_speed_unit': 'Wind Speed Unit',
      'time_format': 'Time Format',
      'language': 'Language',
      'celsius': 'Celsius (°C)',
      'fahrenheit': 'Fahrenheit (°F)',
      'm_s': 'Meters per second (m/s)',
      'km_h': 'Kilometers per hour (km/h)',
      'mph': 'Miles per hour (mph)',
      '24_hour': '24-hour format',
      '12_hour': '12-hour format',
      'english': 'English',
      'vietnamese': 'Vietnamese',
      'spanish': 'Spanish',
      'precipitation': 'Precip',
      'no_weather_data': 'No weather data available',
      'loading': 'Loading...',
      'error': 'Error',
      'try_again': 'Try Again',
      'offline_mode': 'Offline Mode',
      'no_recent_searches': 'No recent searches',
      'search_for_cities': 'Search for cities to see them here',
    },
    'vi': {
      'app_title': 'Ứng dụng Thời tiết',
      'current_weather': 'Thời tiết Hiện tại',
      'hourly_forecast': 'Dự báo Theo giờ',
      'daily_forecast': 'Dự báo 5 Ngày',
      'weather_details': 'Chi tiết Thời tiết',
      'humidity': 'Độ ẩm',
      'wind': 'Gió',
      'pressure': 'Áp suất',
      'visibility': 'Tầm nhìn',
      'sunrise': 'Mặt trời mọc',
      'sunset': 'Mặt trời lặn',
      'feels_like': 'Cảm giác như',
      'search_city': 'Tìm kiếm Thành phố',
      'enter_city_name': 'Nhập tên thành phố',
      'favorite_cities': 'Thành phố Yêu thích',
      'recent_searches': 'Tìm kiếm Gần đây',
      'settings': 'Cài đặt',
      'temperature_unit': 'Đơn vị Nhiệt độ',
      'wind_speed_unit': 'Đơn vị Tốc độ Gió',
      'time_format': 'Định dạng Thời gian',
      'language': 'Ngôn ngữ',
      'celsius': 'Độ C (°C)',
      'fahrenheit': 'Độ F (°F)',
      'm_s': 'Mét trên giây (m/s)',
      'km_h': 'Kilomét trên giờ (km/h)',
      'mph': 'Dặm trên giờ (mph)',
      '24_hour': 'Định dạng 24 giờ',
      '12_hour': 'Định dạng 12 giờ',
      'english': 'Tiếng Anh',
      'vietnamese': 'Tiếng Việt',
      'spanish': 'Tiếng Tây Ban Nha',
      'precipitation': 'Mưa',
      'no_weather_data': 'Không có dữ liệu thời tiết',
      'loading': 'Đang tải...',
      'error': 'Lỗi',
      'try_again': 'Thử lại',
      'offline_mode': 'Chế độ Ngoại tuyến',
      'no_recent_searches': 'Không có tìm kiếm gần đây',
      'search_for_cities': 'Tìm kiếm thành phố để xem ở đây',
    },
    'es': {
      'app_title': 'App del Tiempo',
      'current_weather': 'Tiempo Actual',
      'hourly_forecast': 'Pronóstico por Hora',
      'daily_forecast': 'Pronóstico de 5 Días',
      'weather_details': 'Detalles del Tiempo',
      'humidity': 'Humedad',
      'wind': 'Viento',
      'pressure': 'Presión',
      'visibility': 'Visibilidad',
      'sunrise': 'Amanecer',
      'sunset': 'Atardecer',
      'feels_like': 'Sensación térmica',
      'search_city': 'Buscar Ciudad',
      'enter_city_name': 'Ingrese nombre de ciudad',
      'favorite_cities': 'Ciudades Favoritas',
      'recent_searches': 'Búsquedas Recientes',
      'settings': 'Configuración',
      'temperature_unit': 'Unidad de Temperatura',
      'wind_speed_unit': 'Unidad de Velocidad del Viento',
      'time_format': 'Formato de Hora',
      'language': 'Idioma',
      'celsius': 'Celsius (°C)',
      'fahrenheit': 'Fahrenheit (°F)',
      'm_s': 'Metros por segundo (m/s)',
      'km_h': 'Kilómetros por hora (km/h)',
      'mph': 'Millas por hora (mph)',
      '24_hour': 'Formato 24 horas',
      '12_hour': 'Formato 12 horas',
      'english': 'Inglés',
      'vietnamese': 'Vietnamita',
      'spanish': 'Español',
      'precipitation': 'Precipitación',
      'no_weather_data': 'No hay datos meteorológicos disponibles',
      'loading': 'Cargando...',
      'error': 'Error',
      'try_again': 'Intentar de nuevo',
      'offline_mode': 'Modo Sin Conexión',
      'no_recent_searches': 'No hay búsquedas recientes',
      'search_for_cities': 'Busca ciudades para verlas aquí',
    },
  };

  static String translate(String key, String languageCode) {
    return _translations[languageCode]?[key] ?? _translations['en']![key]!;
  }

  static List<AppLanguage> get availableLanguages => AppLanguage.values.toList();
}