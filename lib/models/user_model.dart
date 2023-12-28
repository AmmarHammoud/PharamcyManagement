import '../shared/constants.dart';

class UserModel {
  late int? statues;
  late String message;
  late String token;
  late User user;

  UserModel(this.statues, this.token, this.message);

  UserModel.formJson(Map<String, dynamic> json) {
    print(json);
    statues = json['status'];
    message = json['message'];
    if(json['data'] != null) user = User.fromJson(json['data']);
  }
}

class User {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String token;
  String? image;

  User(
      {
      required this.name,
      required this.email,
      required this.phone,
      required this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['user']['id'];
    name = json['user']['username'];
    phone = json['user']['mobile'];
    token = json['token'];
  }
}

