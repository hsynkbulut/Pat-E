// ignore_for_file: unnecessary_string_interpolations
import 'package:intl/intl.dart';

class TodayDate {
  String formattedDateTime = '';

  TodayDate() {
    setFormattedDateTime();
  }

  void setFormattedDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    formattedDateTime = '$formattedDate';
  }
}
