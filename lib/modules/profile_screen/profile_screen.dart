import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dac/modules/profile_screen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shared/components.dart';
import 'cubit/states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileCubit()..getUserInformation(),
      child: BlocConsumer<UpdateProfileCubit, UpdateProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          double divisor = 20;
          var updateProfile = UpdateProfileCubit.get(context);
          String formattedBirthdate =
              DateFormat('yyyy/MM/dd').format(updateProfile.birthDate);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Update Profile'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ConditionalBuilder(
                condition: state is! GetUserInformationLoadingState,
                builder: (context) =>
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ValidatedTextField(
                          hasNextText: false,
                            controller: updateProfile.userInfoControllers.nameController,
                            icon: Icons.person,
                            validator:
                                updateProfile.userInfoValidators.nameValidator,
                            errorText: 'Please enter your name',
                            hintText:
                                'user name',
                            onChanged: (String name) => null),
                        SizedBox(
                          height: divisor,
                        ),
                        ValidatedTextField(
                          hasNextText: false,
                            controller: updateProfile.userInfoControllers.emailController,
                            icon: Icons.email,
                            validator:
                                updateProfile.userInfoValidators.emailValidator,
                            errorText: 'Please enter your email',
                            hintText:
                                'email',
                            onChanged: (String email) => null),
                        SizedBox(
                          height: divisor,
                        ),
                        // ValidatedTextField(
                        //     controller: updateProfile.userInfoControllers.phoneController,
                        //     icon: Icons.phone,
                        //     hasNextText: false,
                        //     validator:
                        //         updateProfile.userInfoValidators.phoneValidator,
                        //     errorText: 'Please enter your phone number',
                        //     hintText:
                        //         'phone number',
                        //     onChanged: (String phone) => null),
                        SizedBox(
                          height: divisor,
                        ),
                        DateSelector(
                            hintText: 'birth date:',
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse(
                                      updateProfile.userModel!.user.birthDate),
                                  firstDate: DateTime(1950, 1),
                                  lastDate: DateTime(2101));
                              if (picked != null &&
                                  picked !=
                                      DateTime.parse(updateProfile
                                          .userModel!.user.birthDate)) {
                                updateProfile.changeDate(birthDate: picked);
                              }
                            },
                            shownDate: DateTime.parse(
                                updateProfile.userModel!.user.birthDate)),
                        SizedBox(
                          height: divisor,
                        ),
                        ShowQuestionAnswerBox(
                            controller:
                                updateProfile.userInfoControllers.haveDiseaseController,
                            question: 'Do you have any disease?',
                            cubitObject: updateProfile,
                            validator: updateProfile
                                .userInfoValidators.haveDiseaseValidator,
                            hintText: 'first',
                            errorText: 'first cannot be empty',
                            onChanged: (s) {},
                            switchIndex: 0),
                        SizedBox(
                          height: divisor,
                        ),
                        ShowQuestionAnswerBox(
                            controller:
                                updateProfile.userInfoControllers.medicineUsedController,
                            question: 'Do you use any medication?',
                            cubitObject: updateProfile,
                            validator: updateProfile
                                .userInfoValidators.medicineUsedValidator,
                            hintText: 'second',
                            errorText: 'second cannot be empty',
                            onChanged: (s) {},
                            switchIndex: 1),
                        SizedBox(
                          height: divisor,
                        ),
                        ShowQuestionAnswerBox(
                            controller:
                                updateProfile.userInfoControllers.medicineAllergiesController,
                            question: 'Are you allergic to any medicine?',
                            cubitObject: updateProfile,
                            validator: updateProfile
                                .userInfoValidators.medicineAllergiesValidator,
                            hintText: 'third',
                            errorText: 'third cannot be empty',
                            onChanged: (s) {},
                            switchIndex: 2),
                        SizedBox(
                          height: divisor,
                        ),
                        ShowQuestionAnswerBox(
                            controller:
                                updateProfile.userInfoControllers.foodAllergiesController,
                            question: 'Are you allergic to any food?',
                            cubitObject: updateProfile,
                            validator: updateProfile
                                .userInfoValidators.foodAllergiesValidator,
                            hintText: 'third',
                            errorText: 'third cannot be empty',
                            onChanged: (s) {},
                            switchIndex: 3),
                        CustomizedButton(
                            title: 'update profile',
                            condition: state is! UpdateProfileLoadingState,
                            onPressed: () {
                              updateProfile.updateProfile(
                                context: context,
                                name: updateProfile.userInfoControllers.nameController.text,
                                email: updateProfile.userInfoControllers.emailController.text,
                                image: '',
                                phone: updateProfile.userInfoControllers.phoneController.text,
                                birthDate: DateFormat('yyyy/MM/dd')
                                    .format(updateProfile.birthDate),
                                medicineUsed: updateProfile
                                    .userInfoControllers.medicineUsedController.text,
                                medicineAllergies: updateProfile
                                    .userInfoControllers.medicineAllergiesController.text,
                                foodAllergies: updateProfile
                                    .userInfoControllers.foodAllergiesController.text,
                                haveDisease: updateProfile
                                    .userInfoControllers.haveDiseaseController.text,
                              );
                            })
                      ],
                    ),
                  ),

                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }
}
