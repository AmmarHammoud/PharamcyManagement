import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dac/modules/add_new_product/add_new_medication/add_new_medication_screen.dart';
import 'package:dac/modules/medicines_management/medicine_preview_screen.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class GetTotalMedicinesScreen extends StatelessWidget {
  GetTotalMedicinesScreen({Key? key}) : super(key: key);
  bool isAdmin = CashHelper.isAdmin();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicinesManagementCubit()..getTotalMedicines(),
      child: BlocConsumer<MedicinesManagementCubit, MedicinesManagementStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var medicinesManagement = MedicinesManagementCubit.get(context);
          return Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              title: const Text('all medicines'),
              actions: [],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // if (isAdmin)
                  //   ElevatedButton(
                  //       onPressed: () {
                  //         navigateTo(context, const AddNewMedicationScreen());
                  //       },
                  //       child: const Text('Add new medication')),
                  ConditionalBuilder(
                    condition: state is! GetTotalMedicinesLoadingState,
                    builder: (context) => ListView.separated(
                        physics: const BouncingScrollPhysics(
                            //parent: AlwaysScrollableScrollPhysics()
                            ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: MedicineModelViewer(
                                medId: medicinesManagement
                                    .totalMedicines[index].id,
                                condition: state is! DeleteMedicineLoadingState,
                                name: medicinesManagement
                                    .totalMedicines[index].name,
                                category: medicinesManagement
                                    .totalMedicines[index].category,
                                imagePath: 'images/medicine.png',
                                onPressed: () {
                                  navigateTo(
                                      context,
                                      MedicinePreviewScreen(
                                          medicineModel: medicinesManagement
                                              .totalMedicines[index]));
                                },
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: medicinesManagement.totalMedicines.length),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// class MedicineModelViewer extends StatelessWidget {
//   final String name;
//   final String category;
//   final String imagePath;
//   final bool condition;
//   final Function() onPressed;
//
//   const MedicineModelViewer(
//       {Key? key,
//       required this.name,
//       required this.category,
//       required this.imagePath,
//       required this.condition,
//       required this.onPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double imageSize = 50;
//     return Container(
//       color: Colors.greenAccent,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   imagePath,
//                   width: imageSize,
//                   height: imageSize,
//                 ),
//                 Column(
//                   children: [Text(name), Text(category)],
//                 ),
//               ],
//             ),
//             CustomizedButton(
//                 title: 'view',
//                 condition: condition,
//                 onPressed: onPressed)
//           ],
//         ),
//       ),
//     );
//   }
// }
