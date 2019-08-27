import 'package:intl/intl.dart';

var formatterDayOfWeek = DateFormat("EEEE");
var formatterDate = DateFormat("MMM d y");

bool areDatesEqual(DateTime a, DateTime b) {
  if (a.year == b.year && a.month == b.month && a.day == b.day) {
    return true;
  }
  return false;
}
