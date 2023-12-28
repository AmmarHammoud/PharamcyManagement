
class MedicineModel{

  late int id;
  late String name;
  late String scientificName;
  late String companyName;
  late String category;
  late String activeIngredients;
  late String image;
  late String usesFor;
  late String sideEffects;
  late int quantity;
  late String expireDate;
  late String price;
  MedicineModel.formJson(Map<String, dynamic> json){

    id = json['id'];
    name = json['name'];
    scientificName = json['scientific_name'];
    companyName = json['company_name'];
    category = json['category'];
    activeIngredients = json['active_ingredient'];
    //image = json['img'];
    usesFor = json['uses_for'];
    sideEffects = json['effects'];
    quantity = json['quantity'];
    expireDate = json['expiry_date'];
    price = json['a_price'];
  }

  void printInfo(){
    print('name: $name\nscientificName: $scientificName\ncompanyName: $companyName');
  }

}