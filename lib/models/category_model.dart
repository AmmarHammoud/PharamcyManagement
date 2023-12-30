class CategoryModel {
  late int success;
  late String message;
  late Category category;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    /*for (int i = 0; i < value.data['data'].length; i++) {
      categories.add(Category.fromJson(value.data));
    }*/
    category = Category.fromJson(json['data']);
  }
}

class Category {
  late int id;
  late String title;
  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];

  }
}
