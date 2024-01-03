import 'package:dac/modules/add_new_product/add_new_medication/cubit/cubit.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../shared/constants.dart';
import 'cubit/states.dart';

class AddNewMedicationScreen extends StatelessWidget {
  const AddNewMedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewMedicationCubit(),
      child: BlocConsumer<AddNewMedicationCubit, AddNewMedicationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          double divisor = 20;
          var addNewMedication = AddNewMedicationCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'New medication',
              ),
              actions: [],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // const Text("please enter:",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.normal,
                    //       fontStyle: FontStyle.italic,
                    //       fontSize: 20.0,
                    //       color: Colors.indigoAccent,
                    //       backgroundColor: Colors.white70,
                    //     )),
                    SizedBox(
                      height: divisor,
                    ),
                    MedicineComponents(cubitObject: addNewMedication),
                    SizedBox(
                      height: divisor,
                    ),
                    CustomizedButton(
                        title: 'add new medication',
                        condition: state is! AddNewMedicationLoadingState,
                        onPressed: () {
                          if (addNewMedication.requiredInformationFilled()) {
                            addNewMedication.addNewMedication(
                              context: context,
                                name: addNewMedication.medicineTextControllers.medicineNameController.text,
                                scientificName:
                                    addNewMedication.medicineTextControllers.scientificNameController.text,
                                companyName: addNewMedication.medicineTextControllers.companyNameController.text,
                                category: addNewMedication.medicineTextControllers.categoryController.text,
                                image: 'images/person.png',
                                quantity: addNewMedication.medicineTextControllers.quantityController.text,
                                expiryDate: DateFormat('yyyy/MM/dd')
                                    .format(addNewMedication.medicineTextControllers.expireDate),
                                price: double.parse(addNewMedication.medicineTextControllers.priceController.text),
                                );
                          } else {
                            showToast(
                                context: context,
                                text: 'Please fill the required information',
                                color: Colors.red);
                          }
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
