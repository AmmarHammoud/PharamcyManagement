import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dac/modules/medicines_management/get_total_medicines_screee.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class MedicinesManagementScreen extends StatelessWidget {
  const MedicinesManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicinesManagementCubit(),
      child: BlocConsumer<MedicinesManagementCubit, MedicinesManagementStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var medicinesManagement = MedicinesManagementCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        navigateTo(context, const GetTotalMedicinesScreen());
                      },
                      child: const Text('medicines management')),
                  //MedicineComponents(cubitObject: medicinesManagement)
                ],
              ),
            );
          }),
    );
  }
}
