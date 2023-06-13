import 'package:dac/models/user_model.dart';
import 'package:dac/modules/login_screen/login_screen.dart';
import 'package:dac/modules/register_screen/cubit/states.dart';
import 'package:dac/shared/components.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var birthDate = DateTime.now();

  UserInfoControllers userInfoControllers = UserInfoControllers();
  UserInfoValidators userInfoValidators = UserInfoValidators();

  ///If the image is null, then it's the first time to be selected
  String? image;

  var questions = [false, false, false, false];

  bool passwordIsShown = true;

  Gender? gender = Gender.male;

  changePasswordVisibility() {
    if (passwordIsShown) {
      passwordIsShown = false;
      emit(NotShownPassword());
    } else {
      passwordIsShown = true;
      emit(ShownPassword());
    }
  }

  changeGenderSelection({required Gender? gender}) {
    emit(ChangedText());
    this.gender = gender;
    emit(ChangedText());
  }

  void register({
    required context,
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required bool isMale,
    required String birthDay,
    required String medicineUsed,
    required String medicineAllergies,
    required String foodAllergies,
    required String anotherDisease,
    required String haveDisease,
  }) {
    if (requiredInformationFilled(context: context)) {
      emit(RegisterLoadingState());
      DioHelper.register(
        image: 'images/person.png',
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        phone: phone,
        isMale: isMale,
        birthDay: birthDay,
        medicineUsed: medicineUsed == '' ? '-' : medicineUsed,
        medicineAllergies: medicineAllergies == '' ? '-' : medicineAllergies,
        foodAllergies: foodAllergies == '' ? '-' : foodAllergies,
        anotherDisease: anotherDisease == '' ? '-' : anotherDisease,
        haveDisease: haveDisease == '' ? '-' : haveDisease,
      ).then((value) {
        UserModel registerModel = UserModel.formJson(value.data);
        if (registerModel.statues == null) {
          showToast(
              context: context, text: value.data['message'], color: Colors.red);
        } else {
          showToast(
              context: context,
              text: registerModel.message,
              color: Colors.green);
          navigateAndFinish(context, const LoginScreen());
        }
        emit(RegisterSuccessState());
      }).catchError((error) {
        emit(RegisterErrorState());
      });
    }
  }

  changeImage({required String image}) {
    emit(ChangedText());
    this.image = image;
    emit(ChangedText());
  }

  changeDate({required DateTime picked}) {
    emit(ChangingText());
    birthDate = picked;
    emit(ChangedText());
  }

  changeQuestionSwitch({required int switchIndex}) {
    emit(ChangedText());
    questions[switchIndex] = !questions[switchIndex];
    emit(ChangedText());
  }

  bool validateQuestion(fieldValidator) {
    return fieldValidator ?? true;
  }

  bool requiredInformationFilled({required context}) {
    bool requiredInformationFilled = userInfoValidators
            .nameValidator.currentState!
            .validate() &&
        userInfoValidators.emailValidator.currentState!.validate() &&
        userInfoValidators.passwordValidator.currentState!.validate() &&
        userInfoValidators.passwordConfirmationValidator.currentState!
            .validate() &&
        userInfoValidators.phoneValidator.currentState!.validate() &&
        validateQuestion(
            userInfoValidators.haveDiseaseValidator.currentState?.validate()) &&
        validateQuestion(userInfoValidators.medicineUsedValidator.currentState
            ?.validate()) &&
        validateQuestion(userInfoValidators
            .medicineAllergiesValidator.currentState
            ?.validate()) &&
        validateQuestion(
            userInfoValidators.foodAllergiesValidator.currentState?.validate());
    if (!requiredInformationFilled) {
      showToast(
          context: context,
          text: 'Please enter required information',
          color: Colors.red,
          duration: 4);
      return false;
    }
    return true;
  }
}
