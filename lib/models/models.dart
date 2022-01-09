class CategoryModel {
  int id;
  String title;
  String image;
  List<ItemModel>? itemsList;

  CategoryModel(this.id, this.title, this.image, this.itemsList);
}

class ItemModel {
  int id;
  int storeId;
  String name;
  String description;
  String image;
  double reviews;
  double price;
  int status;
  List<ChoiceModel>? choicesList;
  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.reviews,
    required this.price,
    required this.status,
    required this.storeId,
    this.choicesList,
  });

  // ItemModel(
  //     {required this.id,
  //     required this.title,
  //     required this.description,
  //     required this.image,
  //     required this.calories,
  //     required this.reviews,
  //     required this.price,
  //     required this.status,
  //     this.choicesList});
}

class ChoiceModel {
  int id;
  String title;
  List<SubChoiceModel>? subChoicesList;

  ChoiceModel(this.id, this.title, this.subChoicesList);
}

class SubChoiceModel {
  int id;
  String title;
  double price;

  SubChoiceModel(this.id, this.title, this.price);
}

class CartModel {
  int id;
  String title;
  String description;
  String image;
  double price;

  CartModel(this.id, this.title, this.description, this.image, this.price);
}

class LanguageModel {
  String code;
  String title;

  LanguageModel(this.code, this.title);
}
