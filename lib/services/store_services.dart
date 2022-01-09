import 'package:food_app/models/store_model.dart';
import 'package:food_app/utils/apiService.dart';

class StoreServices {
  static Future<List<StoreModel>> fetchStoreList(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return [StoreModel.fromJson(data)];
  }

  static Future<StoreModel> fetchStore(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return StoreModel.fromJson(data);
  }
}
