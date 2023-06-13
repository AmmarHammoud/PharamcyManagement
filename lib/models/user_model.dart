import '../shared/constants.dart';

class UserModel {
  late int? statues;
  late String message;
  late String token;
  late User user;

  UserModel(this.statues, this.token, this.message);

  UserModel.formJson(Map<String, dynamic> json) {
    statues = json['status'];
    message = json['message'];
    if(json['data']!= null) user = User.fromJson(json['data']);
    if(json['access_token'] != null) token = json['access_token'];
  }
}

class User {
  late int id;
  late String name;
  late String email;
  late String gender;
  late String phone;
  late String birthDate;
  String? image;
  late String medicineUsed;
  late String medicineAllergies;
  late String foodAllergies;
  late String haveDiseases;
  late String anotherDiseases;
  List<bool> questions = [];
  User(
      {
      required this.name,
      required this.email,
      required this.phone,
      required this.image});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['number'];
    gender = json['gender'];
    image = json['image'];
    birthDate = json['b_day'];

    //question1: do you have any diseases?
    haveDiseases = json['have_disease'];
    questions.add(haveDiseases == '-');

    //question2: do you use any medicine?
    medicineUsed = json['medicine_used'];
    questions.add(medicineUsed == '-');

    //question3: Are you allergic to any medicine?
    medicineAllergies = json['medicine_allergies'];
    questions.add(medicineAllergies == '-');

    //question4: Are you allergic to any food?
    foodAllergies = json['food_allergies'];
    questions.add(foodAllergies == '-');



    anotherDiseases = json['another_disease'];
  }
}

