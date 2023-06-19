class OrderModel {
  late String userName;
  late int userId;
  late String medicineName;

  OrderModel(
      {required this.userId,
      required this.userName,
      required this.medicineName});

  OrderModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userId = json['userId'];
    medicineName = json['medicineName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'medicineName': medicineName
    };
  }

  @override
  String toString(){
    return 'userId: $userId, userName: $userName, medicineName: $medicineName';
  }
}
