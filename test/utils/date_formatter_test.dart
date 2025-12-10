import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/utils/date_formatter.dart';

void main() {
  group('DateFormatter Tests', () {
    final testDate = DateTime(2023, 12, 5, 14, 30); 

    test('Should format full date correctly', () {
      final formatted = DateFormatter.formatFullDate(testDate);
      expect(formatted, equals('Tuesday, Dec 5'));
    });

    test('Should format time in 24-hour format', () {
      final formatted = DateFormatter.formatTime(testDate, is24HourFormat: true);
      expect(formatted, equals('14:30'));
    });

    test('Should format time in 12-hour format', () {
      final formatted = DateFormatter.formatTime(testDate, is24HourFormat: false);
      expect(formatted.toLowerCase(), contains('2:30'));
    });

    test('Should format day of week', () {
      final formatted = DateFormatter.formatDayOfWeek(testDate);
      expect(formatted, equals('Tue'));
    });

    test('Should format hour only in 24-hour format', () {
      final formatted = DateFormatter.formatHourOnly(testDate, is24HourFormat: true);
      expect(formatted, equals('14'));
    });

    test('Should format hour only in 12-hour format', () {
      final formatted = DateFormatter.formatHourOnly(testDate, is24HourFormat: false);
      expect(['2 PM', '2 pm'].contains(formatted), isTrue);
    });

    test('Should format day and time', () {
      final formatted = DateFormatter.formatDayAndTime(testDate);
      expect(formatted, equals('Tue, 14:30'));
    });

    test('Should handle midnight (00:00)', () {
      final midnight = DateTime(2023, 12, 5, 0, 0);
      
      final time24 = DateFormatter.formatTime(midnight, is24HourFormat: true);
      expect(time24, equals('00:00'));
      
      final time12 = DateFormatter.formatTime(midnight, is24HourFormat: false);
      expect(time12.toLowerCase(), contains('12'));
    });

    test('Should handle noon (12:00)', () {
      final noon = DateTime(2023, 12, 5, 12, 0);
      
      final time24 = DateFormatter.formatTime(noon, is24HourFormat: true);
      expect(time24, equals('12:00'));
      
      final time12 = DateFormatter.formatTime(noon, is24HourFormat: false);
      expect(time12.toLowerCase(), contains('12'));
    });

    test('Should handle different dates', () {
      final newYears = DateTime(2024, 1, 1, 0, 0);
      final formatted = DateFormatter.formatFullDate(newYears);
      expect(formatted, equals('Monday, Jan 1'));
    });

    test('Should handle different times', () {
      final morning = DateTime(2023, 12, 5, 9, 15);
      final evening = DateTime(2023, 12, 5, 21, 45);
      
      expect(DateFormatter.formatTime(morning, is24HourFormat: true), equals('09:15'));
      expect(DateFormatter.formatTime(evening, is24HourFormat: true), equals('21:45'));
    });
  });
}