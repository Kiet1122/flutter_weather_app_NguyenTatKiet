import 'package:intl/intl.dart';

class DateFormatter {
  
  static String formatFullDate(DateTime dateTime) {
    return DateFormat('EEEE, MMM d', 'en_US').format(dateTime); 
  }

  static String formatTime(DateTime dateTime, {bool is24HourFormat = true}) {
    if (is24HourFormat) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return DateFormat('h:mm a').format(dateTime);
    }
  }

  static String formatDayOfWeek(DateTime dateTime) {
    return DateFormat('EEE').format(dateTime);
  }

  static String formatHourOnly(DateTime dateTime, {bool is24HourFormat = true}) {
     if (is24HourFormat) {
      return DateFormat('H').format(dateTime);
    } else {
      return DateFormat('h a').format(dateTime);
    }
  }

  static String formatDayAndTime(DateTime dateTime) {
    return DateFormat('EEE, HH:mm').format(dateTime);
  }
}