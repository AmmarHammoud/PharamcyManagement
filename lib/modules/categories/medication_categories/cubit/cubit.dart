import 'package:dac/models/category_model.dart';
import 'package:dac/models/search_model/medicine_model/medicine_model.dart';
import 'package:dac/modules/categories/categories.dart';
import 'package:dac/modules/categories/medication_categories/cubit/states.dart';
import 'package:dac/modules/medicines_management/get_total_medicines_screee.dart';
import 'package:dac/shared/components.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMedicineCategoriesCubit extends Cubit<GetMedicineCategoriesStates> {
  GetMedicineCategoriesCubit() : super(GetMedicineCategoriesInitialState());

  static GetMedicineCategoriesCubit get(context) => BlocProvider.of(context);

  List<MedicineModel> categorizedMedicine = [];
  List<Category> categories = [];

  getMedicineAccordingToCategory({required String category}) {
    categorizedMedicine.clear();
    emit(GetMedicineCategoriesLoadingState());
    DioHelper.getCategorizedMedicines(category: category).then((value) {
      print(value.data);
      for (int i = 0; i < value.data.length; i++) {
        categorizedMedicine.add(MedicineModel.formJson(value.data[i]));
      }
      emit(GetMedicineCategoriesSuccessState());
    }).onError((error, stackTrace) {
      emit(GetMedicineCategoriesErrorState());
      print(error.toString());
    });
  }

  getCategories() {
    emit(GetMedicineCategoriesLoadingState());
    DioHelper.getCategories().then((value) {
      print(value.data);
      for (int i = 0; i < value.data['data'].length; i++) {
        categories.add(Category.fromJson(value.data['data'][i]));
      }
      emit(GetMedicineCategoriesSuccessState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(GetMedicineCategoriesErrorState());
    });
  }

  addCategory({required context, required String title}) {
    emit(GetMedicineCategoriesLoadingState());
    DioHelper.addCategory(title: title).then((value) {
      print(value.data);
      emit(GetMedicineCategoriesSuccessState());
      if (value.data['success'] == 1) {
        navigateTo(context, CategorizedMedicineScreen());
        showToast(
            context: context, text: value.data['message'], color: Colors.green);
      } else {
        showToast(
            context: context, text: value.data['message'][0], color: Colors.red);
      }
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(GetMedicineCategoriesErrorState());
    });
  }
}
