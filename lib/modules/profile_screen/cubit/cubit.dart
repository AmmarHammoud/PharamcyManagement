import 'package:dac/modules/profile_screen/cubit/states.dart';
import 'package:dac/shared/constants.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../shared/cash_helper.dart';
import '../../../shared/components.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates> {
  UpdateProfileCubit() : super(UpdateProfileInitialState());

  static UpdateProfileCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  var questions = [false, false, false, false];

  UserInfoControllers userInfoControllers = UserInfoControllers();
  UserInfoValidators userInfoValidators = UserInfoValidators();

  DateTime birthDate = DateTime.now();

  changeDate({required DateTime birthDate}) {
    emit(ChangingBegins());
    this.birthDate = birthDate;
    emit(ChangingEnds());
  }

  changeQuestionSwitch({required int switchIndex}) {
    emit(ChangedText());
    questions[switchIndex] = !questions[switchIndex];
    emit(ChangedText());
  }

  void getUserInformation() {
    emit(GetUserInformationLoadingState());
    DioHelper.getUserInformation(token: CashHelper.getUserToken()!)
        .then((value) {
      userModel = UserModel.formJson(value.data);
      print(value.data);
      userInfoControllers.nameController.text = userModel!.user.name;
      userInfoControllers.phoneController.text = userModel!.user.phone;


      emit(GetUserInformationSuccessState());
    }).catchError((error) {
      print('update profile error: ${error.toString()}');
      emit(GetUserInformationErrorState());
    });
  }

  void updateProfile({
    required context,
    required String name,
    required String email,
    required String image,
    required String phone,
    required String birthDate,
    required String medicineUsed,
    required String medicineAllergies,
    required String foodAllergies,
    required String haveDisease,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.updateProfile(
      token: CashHelper.getUserToken()!,
      name: name,
      email: email,
      image: image,
      phone: phone,
      birthDate: birthDate,
      medicineUsed: medicineUsed,
      medicineAllergies: medicineAllergies,
      foodAllergies: foodAllergies,
      haveDisease: haveDisease,
    ).then((value) {
      showToast(
          context: context,
          text: value.data['message'],
          color: value.data['status'] == 1 ? Colors.green : Colors.red);
      emit(UpdateProfileSuccessState());
    }).catchError((error) {
      emit(UpdateProfileErrorState());
    });
  }
}
