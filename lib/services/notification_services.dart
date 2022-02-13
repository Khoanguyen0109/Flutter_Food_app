import 'package:food_app/models/notification_model.dart';
import 'package:food_app/utils/apiService.dart';

class NotificationServices {
  static Future<List<NotificationModel>> fecthNotificationList() async {
    try {
      String url = 'notification';
      final data = await ApiService.get(url, null);
      print(data);
      List<NotificationModel> dataList = [];
      for (var u in data['data']) {
        NotificationModel notificationModel = NotificationModel.fromMap(u);
        dataList.add(notificationModel);
      }

      return dataList;
    } catch (e) {
      print(e.toString());
      return [];
    }
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
