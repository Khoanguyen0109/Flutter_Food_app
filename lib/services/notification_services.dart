import 'package:food_app/models/notification_model.dart';
import 'package:food_app/utils/apiService.dart';

class NotificationServices {
  static Future<List<NotificationModel>> fecthNotificationList(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return [NotificationModel.fromJson(data)];
  }

  static Future<NotificationModel> fetchNotication(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return NotificationModel.fromJson(data);
  }

  static Future<NotificationModel> readNotification(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return NotificationModel.fromJson(data);
  }
}
