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
      {required context, required String email, required String password}) {
    if (userInfoValidators.emailValidator.currentState!.validate() &&
        userInfoValidators.passwordValidator.currentState!.validate()) {
      emit(LoginLoadingState());
      DioHelper.login(email: email, password: password).then((value) {
        print(value.data);
        UserModel loginModel = UserModel.formJson(value.data);
        CashHelper.putUser(userToken: loginModel.token);
        CashHelper.putUserEmail(email: loginModel.user.email);
        //Future.delayed(const Duration(seconds: 10));
        if (loginModel.statues == 1) {
          navigateAndFinish(
              context,
              HomeScreen());
        }
        showToast(
            context: context,
            text: loginModel.message,
            color: loginModel.statues == 1 ? Colors.green : Colors.red);
        print(loginModel.user.email);

        emit(LoginSuccessState());
      }).catchError((error) {
        print('logging in ${error.toString()}');
        emit(LoginErrorState());
      });
    }
  }
}
