import 'package:intl/intl.dart';

class Utils {
  static formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy – kk:mm').format(date);
  }
}
