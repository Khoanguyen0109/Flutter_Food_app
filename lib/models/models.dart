class CategoryModel {
  int id;
  String title;
  String image;
  List<ItemModel>? itemsList;

  CategoryModel(this.id, this.title, this.image, this.itemsList);
}

class ItemModel {
  int id;
  String title;
  String description;
  String image;
  int calories;
  double reviews;
  double price;
  String time;
  List<ChoiceModel>? choicesList;

  ItemModel(this.id, this.title, this.description, this.image, this.calories,
      this.reviews, this.price, this.time, this.choicesList);
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
