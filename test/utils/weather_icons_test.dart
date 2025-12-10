import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/utils/weather_icons.dart';
import 'package:flutter/material.dart';

void main() {
  group('WeatherIconUtils Tests', () {
    test('Should return correct icon for clear condition', () {
      expect(WeatherIconUtils.getIconForCondition('clear'), equals(Icons.wb_sunny));
      expect(WeatherIconUtils.getIconForCondition('CLEAR'), equals(Icons.wb_sunny));
      expect(WeatherIconUtils.getIconForCondition('Clear'), equals(Icons.wb_sunny));
    });

    test('Should return correct icon for clouds condition', () {
      expect(WeatherIconUtils.getIconForCondition('clouds'), equals(Icons.cloud));
      expect(WeatherIconUtils.getIconForCondition('Clouds'), equals(Icons.cloud));
      expect(WeatherIconUtils.getIconForCondition('CLOUDS'), equals(Icons.cloud));
    });

    test('Should return correct icon for rain condition', () {
      expect(WeatherIconUtils.getIconForCondition('rain'), equals(Icons.beach_access));
      expect(WeatherIconUtils.getIconForCondition('Rain'), equals(Icons.beach_access));
    });

    test('Should return correct icon for drizzle condition', () {
      expect(WeatherIconUtils.getIconForCondition('drizzle'), equals(Icons.grain));
      expect(WeatherIconUtils.getIconForCondition('Drizzle'), equals(Icons.grain));
    });

    test('Should return correct icon for thunderstorm condition', () {
      expect(WeatherIconUtils.getIconForCondition('thunderstorm'), equals(Icons.flash_on));
      expect(WeatherIconUtils.getIconForCondition('Thunderstorm'), equals(Icons.flash_on));
    });

    test('Should return correct icon for snow condition', () {
      expect(WeatherIconUtils.getIconForCondition('snow'), equals(Icons.ac_unit));
      expect(WeatherIconUtils.getIconForCondition('Snow'), equals(Icons.ac_unit));
    });

    test('Should return correct icon for atmospheric conditions', () {
      expect(WeatherIconUtils.getIconForCondition('mist'), equals(Icons.blur_on));
      expect(WeatherIconUtils.getIconForCondition('fog'), equals(Icons.blur_on));
      expect(WeatherIconUtils.getIconForCondition('haze'), equals(Icons.blur_on));
      expect(WeatherIconUtils.getIconForCondition('smoke'), equals(Icons.blur_on));
      expect(WeatherIconUtils.getIconForCondition('dust'), equals(Icons.blur_on));
      expect(WeatherIconUtils.getIconForCondition('sand'), equals(Icons.blur_on));
      expect(WeatherIconUtils.getIconForCondition('ash'), equals(Icons.blur_on));
      expect(WeatherIconUtils.getIconForCondition('squall'), equals(Icons.blur_on));
      expect(WeatherIconUtils.getIconForCondition('tornado'), equals(Icons.blur_on));
    });

    test('Should return help icon for unknown condition', () {
      expect(WeatherIconUtils.getIconForCondition('unknown'), equals(Icons.help_outline));
      expect(WeatherIconUtils.getIconForCondition(''), equals(Icons.help_outline));
      expect(WeatherIconUtils.getIconForCondition('not_a_condition'), equals(Icons.help_outline));
    });

    test('Should normalize condition to lowercase', () {
      expect(WeatherIconUtils.normalizeCondition('CLEAR'), equals('clear'));
      expect(WeatherIconUtils.normalizeCondition('Clear'), equals('clear'));
      expect(WeatherIconUtils.normalizeCondition('clear'), equals('clear'));
      expect(WeatherIconUtils.normalizeCondition('RAIN'), equals('rain'));
      expect(WeatherIconUtils.normalizeCondition(''), equals(''));
    });

    test('Should return default asset path', () {
      expect(WeatherIconUtils.getLocalIconAsset('01d'), equals('assets/icons/default.png'));
      expect(WeatherIconUtils.getLocalIconAsset('10n'), equals('assets/icons/default.png'));
      expect(WeatherIconUtils.getLocalIconAsset(''), equals('assets/icons/default.png'));
    });

    test('Should handle mixed case conditions', () {
      expect(WeatherIconUtils.getIconForCondition('ClEaR'), equals(Icons.wb_sunny));
      expect(WeatherIconUtils.getIconForCondition('cLoUdS'), equals(Icons.cloud));
    });
  });
}