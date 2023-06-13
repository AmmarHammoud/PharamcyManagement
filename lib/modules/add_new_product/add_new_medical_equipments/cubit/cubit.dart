import 'package:dac/modules/add_new_product/add_new_medical_equipments/cubit/states.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewMedicalEquipmentsCubit
    extends Cubit<AddNewMedicalEquipmentsStates> {
  AddNewMedicalEquipmentsCubit() : super(AddNewMedicalEquipmentsInitialState());

  static AddNewMedicalEquipmentsCubit get(context) => BlocProvider.of(context);

  final name = TextEditingController();
  final nameValidator = GlobalKey<FormState>();
  final price = TextEditingController();
  final priceValidator = GlobalKey<FormState>();
  final quantity = TextEditingController();
  final quantityValidator = GlobalKey<FormState>();
  final description = TextEditingController();
  final descriptionValidator = GlobalKey<FormState>();

  void addNewMedicalEquipments(
      {required String image,
      required String name,
      required String description,
      required String quantity,
      required String price}) {
    emit(AddNewMedicalEquipmentsLoadingState());
    DioHelper.addNewProduct(
            token: CashHelper.getUserToken()!,
            image: image,
            name: name,
            description: description,
            quantity: quantity,
            price: price)
        .then((value) {
          print(value.data);
          emit(AddNewMedicalEquipmentsSuccessState());
    })
        .catchError((error) {
          print('error adding new product: ${error.toString()}');
          emit(AddNewMedicalEquipmentsErrorState());
    });
  }
}
