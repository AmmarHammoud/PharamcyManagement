class CategoryModel {
  late int success;
  late String message;
  //late Category category;
  //late List<Category> categories;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    print(json['data']);
    success = json['success'];
    message = json['message'];
    // for (int i = 0; i < json['data'].length; i++) {
    //   categories.add(Category.fromJson(json['data'][i]));
    // }
  }
}

class MyCategory {
  late int id;
  late String title;

  MyCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
