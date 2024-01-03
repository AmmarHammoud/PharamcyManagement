class AdminOrdersModel {
  late int userId;
  late int medId;
  late int quantity;
  late String status;
  late int payment;
  late String userName;
  late String medName;
  late int orderId;
  AdminOrdersModel.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    medId = json['medication_id'];
    quantity = json['quantity'];
    status = json['status'];
    payment = json['payment'];
    userName = json['username'];
    medName = json['commercial_name'];
    orderId = json['id'];
  }

}
