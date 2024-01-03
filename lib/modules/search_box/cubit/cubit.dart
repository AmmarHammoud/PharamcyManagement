import 'package:dac/models/category_model.dart';
import 'package:dac/modules/search_box/cubit/states.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dac/models/search_model/medicine_model/medicine_model.dart';
import '../../../models/category_model.dart';
import '../../../models/search_model/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  final searchValidator = GlobalKey<FormState>();
  final searchController = TextEditingController();

  SearchModel? searchModel;

  CategoryModel? searchCategoryModel;
  List<MedicineModel> medicineModels = [];
  List<MyCategory> categoryModels = [];

  bool searchForEmptyText() {
    bool searchForEmptyText = searchController.text == '';
    emit(SearchForEmptyTextState());
    return searchForEmptyText;
  }

  bool foundResults() {
    bool foundResults = searchModel!.success == 1;
    emit(CheckForSearchResultsState());
    return foundResults;
  }

  void deleteCurrentSearchModels() {
    medicineModels.clear();
    emit(SearchDeleteCurrentResultsState());
  }

  void search(
      {required String token,
      required String searchText,
      required String searchType}) {
    deleteCurrentSearchModels();
    if (searchForEmptyText()) {
      emit(SearchForEmptyTextState());
      return;
    }
    emit(SearchLoadingState());
    DioHelper.search(token: token, searchText: searchText).then((value) {
      print(value.data);
      searchModel = SearchModel.fromJson(value.data);
      if (foundResults()) {
        fillMedicineModels(value.data['data']);
      }
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }

  void searchByCategory({required String title}) {
    emit(SearchLoadingState());
    DioHelper.searchCategory(title: title).then((value) {
      emit(SearchSuccessState());

      ///print(value.data);
      searchCategoryModel = CategoryModel.fromJson(value.data);
      for (int i = 0; i < value.data['data'].length; i++) {
        categoryModels.add(MyCategory.fromJson(value.data['data'][i]));
      }
    }).onError((error, stackTrace) {
      emit(SearchErrorState());
      print(error.toString());
    });
  }

  void fillMedicineModels(List<dynamic> models) {
    for (int i = 0; i < models.length; i++) {
      medicineModels.add(MedicineModel.formJson(models[i]));
    }
  }
}
