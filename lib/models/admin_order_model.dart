class AdminOrdersModel {
  late int userId;
  late int medId;
  late int quantity;
  late String status;
  late int payment;

  AdminOrdersModel.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    medId = json['medication_id'];
    quantity = json['quantity'];
    status = json['status'];
    payment = json['payment'];
  }

}
