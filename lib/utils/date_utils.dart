import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var formatterDayOfWeek = DateFormat("EEEE");
var formatterDate = DateFormat("MMM d y");

bool areDatesEqual(DateTime a, DateTime b) {
  if (a.year == b.year && a.month == b.month && a.day == b.day) {
    return true;
  }
  return false;
}

DateTime dateTimeFromDateTimeAndTimeOfDay(
    DateTime dateTime, TimeOfDay timeOfDay) {
  return new DateTime(dateTime.year, dateTime.month, dateTime.day,
      timeOfDay.hour, timeOfDay.minute);
}
