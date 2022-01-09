import 'package:food_app/models/models.dart';
import 'package:food_app/utils/apiService.dart';

class ItemServices {
  static String api = '';

  static Future<ItemModel> fetchItem(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return ItemModel.fromJson(data);
  }
}
