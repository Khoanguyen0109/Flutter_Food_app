import 'package:food_app/utils/constants.dart';
import 'package:intl/intl.dart';

class Utils {
  static formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy – kk:mm').format(date);
  }

  static renderStatus(int status) {
    if (status == OrderStatus.FINDING) {
      return 'Finding';
    }
    if (status == OrderStatus.PREPARING) {
      return 'Preparing';
    }
    if (status == OrderStatus.DELIVERING) {
      return 'Delivering';
    }
    if (status == OrderStatus.DELIVERD) {
      return 'Deliverd';
    }
    if (status == OrderStatus.REVICED) {
      return 'Recived';
    }
  }
}
