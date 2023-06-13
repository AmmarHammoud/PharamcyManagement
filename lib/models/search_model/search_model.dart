import 'medicine_model/medicine_model.dart';

class SearchModel{
  late String code;
  late String message;
  late List<MedicineModel> medicineModel;
  SearchModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    if(code == "404") return;

  }
}
