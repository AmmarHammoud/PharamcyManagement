import 'dart:io';
import 'package:dac/modules/register_screen/cubit/cubit.dart';
import 'package:dac/modules/register_screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ImagePicker picker = ImagePicker();
          XFile? image;
          var register = RegisterCubit.get(context);
          bool passwordIsShown = register.passwordIsShown;
          double divisor = 20;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(AppLocal.register.getString(context)),
                actions: const [TranslateButton()],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          image = await picker.pickImage(
                              source: ImageSource.gallery);
                          register.changeImage(image: image!.path);
                        },
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: register.image == null
                                ? const AssetImage('images/person.jpg')
                                : Image.file(File(register.image!)).image
                            //AssetImage(register.image),
                            ),
                      ),
                      SizedBox(
                        height: divisor,
                      ),
                      ValidatedTextField(
                          controller:
                              register.userInfoControllers.nameController,
                          icon: Icons.person,
                          validator: register.userInfoValidators.nameValidator,
                          errorText: 'Please enter your name',
                          hintText: AppLocal.userName.getString(context),
                          onChanged: (String name) => null),
                      // ValidatedTextField(
                      //     controller:
                      //         register.userInfoControllers.emailController,
                      //     icon: Icons.email,
                      //     validator: register.userInfoValidators.emailValidator,
                      //     errorText: 'Please enter your email',
                      //     hintText: 'email',
                      //     onChanged: (String email) => null),
                      SizedBox(
                        height: divisor,
                      ),
                      ValidatedTextField(
                          controller:
                              register.userInfoControllers.passwordController,
                          icon: Icons.lock,
                          obscureText: passwordIsShown,
                          validator:
                              register.userInfoValidators.passwordValidator,
                          errorText: 'Please enter your password',
                          hintText: AppLocal.password.getString(context),
                          onChanged: (String password) => null,
                          suffixIcon: showPasswordIcon(
                              onPressed: () {
                                register.changePasswordVisibility();
                              },
                              passwordIsShown: passwordIsShown)),
                      SizedBox(
                        height: divisor,
                      ),
                      ValidatedTextField(
                          controller: register.userInfoControllers
                              .passwordConfirmationController,
                          icon: Icons.lock,
                          obscureText: passwordIsShown,
                          validator: register
                              .userInfoValidators.passwordConfirmationValidator,
                          errorText: 'Please enter your password again',
                          hintText: AppLocal.reWritePassword.getString(context),
                          onChanged: (String passwordConfirmation) => null,
                          suffixIcon: showPasswordIcon(
                              onPressed: () {
                                register.changePasswordVisibility();
                              },
                              passwordIsShown: passwordIsShown)),
                      SizedBox(
                        height: divisor,
                      ),
                      ValidatedTextField(
                          controller:
                              register.userInfoControllers.phoneController,
                          icon: Icons.phone,
                          hasNextText: false,
                          validator: register.userInfoValidators.phoneValidator,
                          errorText: 'Please enter your phone number',
                          hintText: AppLocal.password.getString(context),
                          onChanged: (String phone) => null),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: register.birthDate,
                                firstDate: DateTime(1950, 1),
                                lastDate: DateTime(2101));
                            if (picked != null &&
                                picked != register.birthDate) {
                              register.changeDate(picked: picked);
                            }
                          },
                          child: ValidatedTextField(
                              controller: TextEditingController(),
                              icon: Icons.calendar_month,
                              enable: false,
                              validator: GlobalKey<FormState>(),
                              errorText: '',
                              hintText: DateFormat('yyyy/MM/dd')
                                  .format(register.birthDate),
                              onChanged: (x) {})),
                      //GenderSelection(register: register),
                      SizedBox(
                        height: divisor,
                      ),
                      CustomizedButton(
                        title: 'register',
                        condition: state is! RegisterLoadingState,
                        onPressed: () {
                          register.register(
                            context: context,
                            name: register
                                .userInfoControllers.nameController.text,
                            password: register
                                .userInfoControllers.passwordController.text,
                            phone: register
                                .userInfoControllers.phoneController.text,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
