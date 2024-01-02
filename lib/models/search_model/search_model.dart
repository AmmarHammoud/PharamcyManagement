import 'medicine_model/medicine_model.dart';

class SearchModel{
  late int success;
  late String message;
  late List<MedicineModel> medicineModel;
  SearchModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];

  }
}
