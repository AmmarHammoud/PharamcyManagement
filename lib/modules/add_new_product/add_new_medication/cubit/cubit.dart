import 'package:dac/modules/add_new_product/add_new_medication/cubit/states.dart';
import 'package:dac/modules/medicines_management/get_total_medicines_screee.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/components.dart';
import 'package:dac/shared/constants.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AddNewMedicationCubit extends Cubit<AddNewMedicationStates> {
  AddNewMedicationCubit() : super(AddNewMedicationInitialState());

  static AddNewMedicationCubit get(context) => BlocProvider.of(context);

  MedicineTextValidators medicineTextValidators = MedicineTextValidators();
  MedicineTextControllers medicineTextControllers = MedicineTextControllers();

  void addNewMedication({
    required context,
    required String name,
    required String scientificName,
    required String companyName,
    required int category,
    required String image,
    required String quantity,
    required String expiryDate,
    required double price,
    //required String b_price
  }) {
    emit(AddNewMedicationLoadingState());
    DioHelper.addNewMedication(
            token: CashHelper.getUserToken()!,
            name: name,
            scientificName: scientificName,
            companyName: companyName,
            category: category,
            image: image,
            quantity: quantity,
            expiryDate: expiryDate,
            price: price)
        .then((value) {
          print(value.data);
      emit(AddNewMedicationSuccessfulState());
      if(value.data['success'] == 1) {
        navigateAndFinish(context, GetTotalMedicinesScreen());
        showToast(
            context: context,
            text: value.data['message'],
            color: Colors.green);
      }
      else {
        showToast(
          context: context,
          text: value.data['message'],
          color: Colors.red);
      }
    }).catchError((error) {
      emit(AddNewMedicationErrorState());
    });
  }

  void changeDate({required DateTime expireDate}) {
    emit(ChangingDate());
    medicineTextControllers.expireDate = expireDate;
    emit(ChangingDate());
  }

  bool validateField(fieldValidator) {
    return fieldValidator ?? true;
  }

  bool requiredInformationFilled() {
    return validateField(medicineTextValidators
            .medicineNameValidator.currentState
            ?.validate()) &&
        validateField(
            medicineTextValidators
                .scientificNameValidator.currentState
                ?.validate()) &&
        validateField(
            medicineTextValidators
                .companyNameValidator.currentState
                ?.validate()) &&
        validateField(
            medicineTextValidators
                .categoryValidator.currentState
                ?.validate()) &&
        validateField(
            medicineTextValidators
                .quantityValidator.currentState
                ?.validate()) &&
        // validateField(medicineTextValidators
        //     .usesForValidator.currentState
        //     ?.validate()) &&
        // validateField(
        //     medicineTextValidators
        //         .sideEffectsValidator.currentState
        //         ?.validate()) &&
        // validateField(medicineTextValidators
        //     .activeIngredientValidator.currentState
        //     ?.validate()) &&
        validateField(
            medicineTextValidators.priceValidator.currentState?.validate());
  }

  // addTenMedicines(context) {
  //   for (int i = 1; i <= 10; i++) {
  //     addNewMedication(
  //       context: context,
  //         name: 'medicine--- $i',
  //         scientificName: 'scientificName $i',
  //         companyName: 'companyName $i',
  //         category: 'opth',
  //         image: 'images/person.png',
  //         quantity: i.toString(),
  //         usesFor: 'usesFor $i',
  //         sideEffects: 'sideEffects $i',
  //         expiryDate: '2020/$i/$i',
  //         a_price: i.toString());
  //   }
  // }
}
