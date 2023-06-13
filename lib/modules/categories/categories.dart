import 'package:dac/modules/add_new_product/add_new_medication/add_new_medication_screen.dart';
import 'package:dac/modules/add_new_product/add_new_medication/cubit/cubit.dart';
import 'package:dac/modules/add_new_product/add_new_medication/cubit/states.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../search_box/search_box.dart';
import 'medication_categories/digestive_medicine.dart';
import 'medication_categories/heart_medicine.dart';
import 'medication_categories/neurological_medicine.dart';
import 'medication_categories/ophthalmic_medicine.dart';
import 'medication_categories/skin_medicine.dart';

class CategorizedMedicineScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewMedicationCubit(),
      child: BlocConsumer<AddNewMedicationCubit, AddNewMedicationStates>(
        listener: (context, state) {},
        builder: (context, state) =>
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'categorized medicine',
                ),
              ),
              drawer: const MyDrawer(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SearchBox(),
                      const SizedBox(
                        height: 15.0,
                      ),
                      CustomizedButton(
                        title: 'add new medication',
                        condition: state is! AddNewMedicationLoadingState,
                        onPressed: () {
                          navigateTo(context, const AddNewMedicationScreen());
                        },),
                      const SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: 500,
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: const [
                              CategoriesScreenButton(
                                title: 'heart',
                                widget: HeartMedicine(),
                                imagePath: 'images/heart.png',
                              ),
                              CategoriesScreenButton(
                                title: 'skin',
                                widget: SkinMedicine(),
                                imagePath: 'images/skin.png',
                              ),
                              CategoriesScreenButton(
                                title: 'nero',
                                widget: NeurologicalMedicine(),
                                imagePath: 'images/neuron.png',
                              ),
                              CategoriesScreenButton(
                                title: 'dig',
                                widget: DigestiveMedicine(),
                                imagePath: 'images/digestive.png',
                              ),
                              CategoriesScreenButton(
                                title: 'opth',
                                widget: OphthalmicMedicine(),
                                imagePath: 'images/ophtalmology.png',
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
