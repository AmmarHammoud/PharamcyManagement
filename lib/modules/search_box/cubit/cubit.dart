import 'package:dac/modules/search_box/cubit/states.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dac/models/search_model/medicine_model/medicine_model.dart';
import '../../../models/search_model/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  final searchValidator = GlobalKey<FormState>();
  final searchController = TextEditingController();

  SearchModel? searchModel;
  List<MedicineModel> medicineModels = [];

  bool searchForEmptyText(){
    bool searchForEmptyText  = searchController.text == '';
    emit(SearchForEmptyTextState());
    return searchForEmptyText;
  }

  bool foundResults(){
    bool foundResults = searchModel!.code != '404';
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
    if(searchForEmptyText()) {emit(SearchForEmptyTextState()); return;}
    emit(SearchLoadingState());
    DioHelper.search(
            token: token, searchText: searchText, searchType: searchType)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      if (foundResults()) {
        fillMedicineModels(value.data['data']['data']);
      }
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }

  void fillMedicineModels(List<dynamic> models) {
    for (int i = 0; i < models.length; i++) {
      medicineModels.add(MedicineModel.formJson(models[i]));
    }
  }
}
