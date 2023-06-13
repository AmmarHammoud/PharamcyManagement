import 'package:dac/modules/add_new_product/add_new_medical_equipments/cubit/cubit.dart';
import 'package:dac/modules/add_new_product/add_new_medical_equipments/cubit/states.dart';
import 'package:dac/shared/components.dart';
import 'package:dac/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewEquipment extends StatelessWidget {
  const AddNewEquipment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewMedicalEquipmentsCubit(),
      child: BlocConsumer<AddNewMedicalEquipmentsCubit,
              AddNewMedicalEquipmentsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var addNewMedicalEquipments =
                AddNewMedicalEquipmentsCubit.get(context);
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'New Equipment',
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    //physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/medical_equipments.png',
                          width: imageSize,
                          height: imageSize,
                        ),
                        const SizedBox(
                          height: divisor,
                        ),
                        ValidatedTextField(
                            controller: addNewMedicalEquipments.name,
                            icon: Icons.drive_file_rename_outline,
                            validator: addNewMedicalEquipments.nameValidator,
                            errorText: 'name field must be filled',
                            hintText: 'name',
                            onChanged: (name) {}),
                        const SizedBox(
                          height: divisor,
                        ),
                        ValidatedTextField(
                            controller: addNewMedicalEquipments.description,
                            icon: Icons.description_outlined,
                            validator:
                                addNewMedicalEquipments.descriptionValidator,
                            errorText: 'description field must be filled',
                            hintText: 'description',
                            onChanged: (description) {}),
                        const SizedBox(
                          height: divisor,
                        ),
                        ValidatedTextField(
                            controller: addNewMedicalEquipments.quantity,
                            icon: Icons.production_quantity_limits_rounded,
                            validator:
                                addNewMedicalEquipments.quantityValidator,
                            errorText: 'quantity field must be filled',
                            hintText: 'quantity',
                            onChanged: (quantity) {}),
                        const SizedBox(
                          height: divisor,
                        ),
                        ValidatedTextField(
                            controller: addNewMedicalEquipments.price,
                            icon: Icons.price_change,
                            validator: addNewMedicalEquipments.priceValidator,
                            errorText: 'price filed must be filled',
                            hintText: 'price',
                            onChanged: (price) {}),
                        const SizedBox(
                          height: divisor,
                        ),
                        CustomizedButton(
                            title: 'add new medical equipments',
                            condition:
                                state is! AddNewMedicalEquipmentsLoadingState,
                            onPressed: () {
                              addNewMedicalEquipments.addNewMedicalEquipments(
                                  image: '-',
                                  name: addNewMedicalEquipments.name.text,
                                  description:
                                      addNewMedicalEquipments.description.text,
                                  quantity:
                                      addNewMedicalEquipments.quantity.text,
                                  price: addNewMedicalEquipments.price.text);
                            })
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
