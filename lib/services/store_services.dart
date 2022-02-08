import 'package:food_app/models/models.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/utils/apiService.dart';

class StoreServices {
  static Future<List<StoreModel>> fetchStoreList(
    String? search,
    int? category,
  ) async {
    try {
      String url = 'auth/merchant';
      print(category);
      final data = await ApiService.get(url, null);
      List<StoreModel> dataList = [];
      for (var u in data['data']) {
        StoreModel storeModel = StoreModel.fromMap(u);
        dataList.add(storeModel);
      }
      return dataList;
    } catch (e) {
      print(e.toString());
      List<StoreModel> a = [];
      return a;
    }
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

  static Future<StoreModel> fetchStore(String id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return StoreModel.fromJson(data);
  }
}
