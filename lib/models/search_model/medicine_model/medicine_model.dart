import 'package:dac/shared/constants.dart';

class MedicineModel {
  late int id;
  late String name;
  late String scientificName;
  late String companyName;
  late String category;
  late String image;
  late int quantity;
  late String expireDate;
  late double price;

  MedicineModel(
      {required this.id,
      required this.name,
      required this.scientificName,
      required this.companyName,
      required this.category,
      required this.image,
      required this.quantity,
      required this.expireDate,
      required this.price});

  MedicineModel.formJson(Map<String, dynamic> json) {
    print('json: $json');
    id = json['id'];
    scientificName = json['scientific_name'];
    name = json['commercial_name'];
    companyName = json['manufacture'];
    price = json['price'];
    expireDate = json['expiry_date'];
    quantity = json['quantity'];
    if (json['category'] != null) category = json['category'];
    else category = 'cat';
    //image = json['img'];
  }

  void printInfo() {
    print(
        'name: $name\nscientificName: $scientificName\ncompanyName: $companyName');
  }
}
