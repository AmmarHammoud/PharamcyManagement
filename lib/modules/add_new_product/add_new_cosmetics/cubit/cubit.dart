import 'package:dac/modules/add_new_product/add_new_cosmetics/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AddNewCosmeticCubit extends Cubit<AddNewCosmeticsStates> {
  AddNewCosmeticCubit() : super(AddNewCosmeticsInitialState());

  static AddNewCosmeticCubit get(context) => BlocProvider.of(context);

  final name = TextEditingController();
  final nameValidator = GlobalKey<FormState>();
  final price = TextEditingController();
  final priceValidator = GlobalKey<FormState>();
  final quantity = TextEditingController();
  final quantityValidator = GlobalKey<FormState>();
  final description = TextEditingController();
  final descriptionValidator = GlobalKey<FormState>();

  void addNewCosmetics(
      {required String name,
      required String price,
      required String quantity,
      required String description}) {}
}
