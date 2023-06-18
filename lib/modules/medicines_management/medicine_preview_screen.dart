import 'package:dac/modules/medicines_management/cubit/cubit.dart';
import 'package:dac/modules/medicines_management/cubit/states.dart';
import 'package:dac/shared/notificatinos_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/search_model/medicine_model/medicine_model.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';

class MedicinePreviewScreen extends StatelessWidget {
  final MedicineModel medicineModel;

  const MedicinePreviewScreen({Key? key, required this.medicineModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicinesManagementCubit(),
      child: BlocConsumer<MedicinesManagementCubit, MedicinesManagementStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var medicineManagement = MedicinesManagementCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
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
                    const SizedBox(
                      height: divisor,
                    ),
                    CustomizedButton(
                        title: 'update medicine info',
                        condition:
                            state is! UpdateMedicineInformationLoadingState,
                        onPressed: () {}),
                    CustomizedButton(
                        color: Colors.red,
                        title: 'delete medicine',
                        condition: state is! DeleteMedicineLoadingState,
                        onPressed: () {
                          medicineManagement.deleteMedicine(
                              context: context, id: medicineModel.id);
                        }),
                    CustomizedButton(
                        title: 'order',
                        condition: true,
                        onPressed: () {
                          NotificationsService.sendOrderNotification(
                              userOrder: {
                                'userID': 1,
                                'userName': 'UserName',
                                'medicineName': 'medicineName'
                              });
                        })
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
