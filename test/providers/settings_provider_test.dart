import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/providers/settings_provider.dart';

void main() {
  group('SettingsProvider Tests', () {
    late SettingsProvider provider;

    setUp(() {
      provider = SettingsProvider();
    });

    test('Initial values should be correct', () {
      expect(provider.temperatureUnit, equals(TemperatureUnit.celsius));
      expect(provider.windSpeedUnit, equals(WindSpeedUnit.ms));
      expect(provider.is24HourFormat, equals(true));
    });

    test('Should change temperature unit', () {
      provider.setTemperatureUnit(TemperatureUnit.fahrenheit);
      expect(provider.temperatureUnit, equals(TemperatureUnit.fahrenheit));

      provider.setTemperatureUnit(TemperatureUnit.celsius);
      expect(provider.temperatureUnit, equals(TemperatureUnit.celsius));
    });

    test('Should format temperature correctly', () {
      expect(provider.formatTemperature(25.5), equals('26°C'));

      provider.setTemperatureUnit(TemperatureUnit.fahrenheit);
      expect(provider.formatTemperature(25.5), equals('78°F'));

      provider.setTemperatureUnit(TemperatureUnit.celsius);
      expect(provider.formatTemperature(-5.5), equals('-6°C'));

      provider.setTemperatureUnit(TemperatureUnit.fahrenheit);
      expect(provider.formatTemperature(-5.5), equals('22°F'));

      provider.setTemperatureUnit(TemperatureUnit.celsius);
      expect(provider.formatTemperature(0.0), equals('0°C'));
    });

    test('Should change wind speed unit', () {
      provider.setWindSpeedUnit(WindSpeedUnit.kmh);
      expect(provider.windSpeedUnit, equals(WindSpeedUnit.kmh));

      provider.setWindSpeedUnit(WindSpeedUnit.mph);
      expect(provider.windSpeedUnit, equals(WindSpeedUnit.mph));

      provider.setWindSpeedUnit(WindSpeedUnit.ms);
      expect(provider.windSpeedUnit, equals(WindSpeedUnit.ms));
    });

    test('Should format wind speed correctly', () {
      expect(provider.formatWindSpeed(5.5), equals('5.5 m/s'));

      provider.setWindSpeedUnit(WindSpeedUnit.kmh);
      expect(provider.formatWindSpeed(5.5), equals('19.8 km/h'));

      provider.setWindSpeedUnit(WindSpeedUnit.mph);
      expect(provider.formatWindSpeed(5.5), equals('12.3 mph'));

      provider.setWindSpeedUnit(WindSpeedUnit.ms);
      expect(provider.formatWindSpeed(0.0), equals('0.0 m/s'));
    });

    test('Should change time format', () {
      provider.set24HourFormat(false);
      expect(provider.is24HourFormat, equals(false));

      provider.set24HourFormat(true);
      expect(provider.is24HourFormat, equals(true));
    });

    test('Should translate text', () {
      expect(provider.translate('app_title'), equals('Weather App'));
      expect(provider.translate('humidity'), equals('Humidity'));
      expect(provider.translate('wind'), equals('Wind'));
      expect(() => provider.translate('app_title'), returnsNormally);
    });
  });
}