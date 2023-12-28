import 'package:dac/models/user_model.dart';
import 'package:dac/modules/home_screen/home_screen.dart';
import 'package:dac/modules/login_screen/cubit/states.dart';
import 'package:dac/shared/components.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dac/shared/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserInfoControllers userInfoControllers = UserInfoControllers();
  UserInfoValidators userInfoValidators = UserInfoValidators();

  bool passwordIsShown = true;

  changePasswordVisibility() {
    if (passwordIsShown) {
      passwordIsShown = false;
      emit(NotShownPassword());
    } else {
      passwordIsShown = true;
      emit(ShownPassword());
    }
  }

  void login(
      {required context, required String phone, required String password}) {
    if (userInfoValidators.phoneValidator.currentState!.validate() &&
        userInfoValidators.passwordValidator.currentState!.validate()) {
      emit(LoginLoadingState());
      DioHelper.login(phone: phone, password: password).then((value) async {
        print(value.data);
        UserModel loginModel = UserModel.formJson(value.data);
        print('STATUS: ${loginModel.statues}');
        if (loginModel.statues == 1) {
          CashHelper.putUser(userToken: loginModel.user.token);
          CashHelper.putUserPhone(mobile: loginModel.user.phone);
          CashHelper.putUserId(id: loginModel.user.id);
          navigateAndFinish(context, HomeScreen());
        }
        //if(loginModel.statues == 0) {
        showToast(
            context: context,
            text: loginModel.message,
            color: loginModel.statues == 1 ? Colors.green : Colors.red);
        //}
        //print(loginModel.user.email);

        emit(LoginSuccessState());
      }).catchError((error) {
        print('logging in ${error.toString()}');
        emit(LoginErrorState());
      });
    }
  }
}
