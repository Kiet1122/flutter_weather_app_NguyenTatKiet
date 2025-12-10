import 'models/weather_model_test.dart' as weather_model_test;
import 'models/forecast_model_test.dart' as forecast_model_test;
import 'models/location_model_test.dart' as location_model_test;
import 'providers/settings_provider_test.dart' as settings_provider_test;
import 'services/storage_service_test.dart' as storage_service_test;
import 'services/weather_service_test.dart' as weather_service_test;
import 'services/location_service_test.dart' as location_service_test;
import 'services/connectivity_service_test.dart' as connectivity_service_test;
import 'utils/date_formatter_test.dart' as date_formatter_test;
import 'utils/weather_icons_test.dart' as weather_icons_test;
import 'widgets/current_weather_card_test.dart' as current_weather_card_test;

void main() {
  weather_model_test.main();
  forecast_model_test.main();
  location_model_test.main();
  settings_provider_test.main();
  storage_service_test.main();
  weather_service_test.main();
  location_service_test.main();
  connectivity_service_test.main();
  date_formatter_test.main();
  weather_icons_test.main();
  current_weather_card_test.main();
}