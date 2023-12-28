import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dac/modules/medicines_management/cubit/states.dart';
import 'package:dac/modules/medicines_management/get_total_medicines_screee.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/components.dart';
import 'package:dac/shared/constants.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/search_model/medicine_model/medicine_model.dart';

class MedicinesManagementCubit extends Cubit<MedicinesManagementStates> {
  MedicinesManagementCubit() : super(MedicinesManagementInitialState());

  static MedicinesManagementCubit get(context) => BlocProvider.of(context);

  MedicineTextControllers medicineTextControllers = MedicineTextControllers();
  MedicineTextValidators medicineTextValidators = MedicineTextValidators();

  List<MedicineModel> totalMedicines = [];

  void getTotalMedicines() {
    totalMedicines.clear();
    emit(GetTotalMedicinesLoadingState());
    DioHelper.getTotalMedicines(token: CashHelper.getUserToken()!)
        .then((value) {
          print(value.data);
      for (int i = 0; i < value.data['data'].length; i++) {
        totalMedicines.add(MedicineModel.formJson(value.data['data'][i]));

      }
      emit(GetTotalMedicinesSuccessState());
    }).catchError((error) {
      print('error in getTotalMedicines: ${error.toString()}');
      emit(GetTotalMedicinesErrorState());
    });
  }

  void deleteMedicine({required int id, required context,}) {
    emit(DeleteMedicineLoadingState());
    DioHelper.deleteMedicine(token: CashHelper.getUserToken()!, id: id)
        .then((value) {
      print(value.data);
      emit(DeleteMedicineSuccessState());
      navigateAndFinish(context, GetTotalMedicinesScreen());
      showToast(context: context, text: value.data['message'], color: Colors.green);
    }).catchError((error) {
      print('error deleting: ${error.toString()}');
      emit(DeleteMedicineErrorState());
    });
    getTotalMedicines();
  }

  void changeDate({required DateTime expireDate}) {
    emit(ChangingDate());
    medicineTextControllers.expireDate = expireDate;
    emit(ChangedDate());
  }

  void updateMedicineInformation(
      {required String name,
      required String scientificName,
      required String companyName,
      required String category,
      required String activeIngredient,
      required String image,
      required String quantity,
      required String usesFor,
      required String sideEffects,
      required String expiryDate,
      required String a_price,}) {
    emit(UpdateMedicineInformationLoadingState());
    DioHelper.updateMedicineInformation(
            token: CashHelper.getUserToken()!,
            name: name,
            scientificName: scientificName,
            companyName: companyName,
            category: category,
            activeIngredient: activeIngredient,
            image: image,
            quantity: quantity,
            usesFor: usesFor,
            sideEffects: sideEffects,
            expiryDate: expiryDate,
            a_price: a_price,)
        .then((value) {
      print(value.data);
      emit(UpdateMedicineInformationSuccessState());
    }).catchError((error) {
      print('error updating medicine info: ${error.toString()}');
      emit(UpdateMedicineInformationErrorState());
    });
  }

  void getMedicineDetails({required int id}){

  }
}
