import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dac/modules/login_screen/cubit/cubit.dart';
import 'package:dac/modules/login_screen/cubit/states.dart';
import 'package:dac/modules/register_screen/register_screen.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var login = LoginCubit.get(context);
            bool passwordIsShown = login.passwordIsShown;
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('login'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ValidatedTextField(
                          controller: login.userInfoControllers.emailController,
                          icon: Icons.email,
                          validator: login.userInfoValidators.emailValidator,
                          errorText: 'email field cannot be empty',
                          hintText: 'email',
                          onChanged: (String email) => null),
                      const SizedBox(
                        height: 10,
                      ),
                      ValidatedTextField(
                          controller: login.userInfoControllers.passwordController,
                          icon: Icons.lock,
                          hasNextText: false,
                          obscureText: passwordIsShown,
                          validator: login.userInfoValidators.passwordValidator,
                          errorText: 'password is incorrect',
                          hintText: 'password',
                          onChanged: (String password) => null,
                          suffixIcon: showPasswordIcon(
                              onPressed: () {
                                login.changePasswordVisibility();
                              },
                              passwordIsShown: passwordIsShown)),
                      ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => ElevatedButton(
                              child: const Text('login'),
                              onPressed: () {
                                login.login(
                                    context: context,
                                    email: login.userInfoControllers
                                        .emailController.text,
                                    password: login.userInfoControllers
                                        .passwordController.text);
                              }),
                          fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              )),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, const RegisterScreen());
                          },
                          child: const Text('register')),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
