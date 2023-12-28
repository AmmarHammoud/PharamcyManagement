import 'package:dac/models/search_model/medicine_model/medicine_model.dart';
import 'package:dac/modules/categories/medication_categories/cubit/states.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMedicineCategoriesCubit extends Cubit<GetMedicineCategoriesStates> {
  GetMedicineCategoriesCubit() : super(GetMedicineCategoriesInitialState());

  static GetMedicineCategoriesCubit get(context) => BlocProvider.of(context);

  List<MedicineModel> categorizedMedicine = [];

  getMedicineCategories({required String category}) {
    categorizedMedicine.clear();
    emit(GetMedicineCategoriesLoadingState());
    DioHelper.getCategorizedMedicines(category: category).then((value) {
      print(value.data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
