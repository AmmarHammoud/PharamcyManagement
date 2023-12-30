
import 'package:dac/shared/constants.dart';

class MedicineModel{

  late int id;
  late String name;
  late String scientificName;
  late String companyName;
  late String category;
  late String image;
  late int quantity;
  late String expireDate;
  late double price;
  MedicineModel.formJson(Map<String, dynamic> json){

    id = json['id'];
    scientificName = json['scientific_name'];
    name = json['commercial_name'];
    companyName = json['manufacture'];
    price = json['price'];
    expireDate = json['expiry_date'];
    quantity = json['quantity'];
    category = cat[json['category_id'].toString()];
    //image = json['img'];
  }

  void printInfo(){
    print('name: $name\nscientificName: $scientificName\ncompanyName: $companyName');
  }

}