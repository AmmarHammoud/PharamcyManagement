import 'package:dac/modules/medicines_management/cubit/cubit.dart';
import 'package:dac/modules/medicines_management/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/search_model/medicine_model/medicine_model.dart';
import '../../shared/cash_helper.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';

class MedicinePreviewScreen extends StatelessWidget {
  final MedicineModel medicineModel;

  final bool isAdmin = CashHelper.isAdmin();
   MedicinePreviewScreen({Key? key, required this.medicineModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicinesManagementCubit(),
      child: BlocConsumer<MedicinesManagementCubit, MedicinesManagementStates>(
        listener: (context, state) {},
        builder: (context, state) {
          bool isChanged(String text) {
            return text == '';
          }

          var medicineManagement = MedicinesManagementCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('medicine details'),
              actions: [],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    Image.asset(
                      'images/medicine.png',
                      width: imageSize,
                      height: imageSize,
                    ),
                    const SizedBox(
                      height: divisor,
                    ),
                    MedicineComponents(
                      cubitObject: medicineManagement,
                      medicineModel: medicineModel,
                    ),
                    // const SizedBox(
                    //   height: divisor,
                    // ),
                    // if(isAdmin)CustomizedButton(
                    //     title: 'update medicine info',
                    //     condition:
                    //         state is! UpdateMedicineInformationLoadingState,
                    //     onPressed: () {}),
                    // if(isAdmin)CustomizedButton(
                    //     color: Colors.red,
                    //     title: 'delete medicine',
                    //     condition: state is! DeleteMedicineLoadingState,
                    //     onPressed: () {
                    //       medicineManagement.deleteMedicine(
                    //           context: context, id: medicineModel.id);
                    //     })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
