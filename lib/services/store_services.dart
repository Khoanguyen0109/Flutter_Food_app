import 'package:food_app/models/models.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/utils/apiService.dart';

class StoreServices {
  static Future<List<StoreModel>> fetchStoreList(
      int? category, String? search) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return [StoreModel.fromJson(data)];
  }

  static Future<List<StoreModel>> fetchPopularStoreList() async {
    String url = '';
    final data = await ApiService.get(url, null);
    return [StoreModel.fromJson(data)];
  }

  static Future<List<CategoryModel>> fetchCategoryList(int? category) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return [CategoryModel.fromJson(data)];
  }

  static Future<StoreModel> fetchStore(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return StoreModel.fromJson(data);
  }
}
