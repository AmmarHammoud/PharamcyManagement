import 'package:dac/modules/add_new_product/add_new_medical_equipments/add_new_medical_equipments.dart';
import 'package:dac/shared/components.dart';
import 'package:dac/shared/constants.dart';
import 'package:flutter/material.dart';
import '../categories/categories.dart';
import '../categories/medication_categories/cosmatics.dart';
import '../categories/medication_categories/medical_equipments.dart';
import '../medicines_management/medicines_management.dart';
import '../search_box/search_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notification_important_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person_pin)),
          ],
        ),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: divisor,
                ),
                const SearchBox(),
                const SizedBox(
                  height: divisor,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 500,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: [
                        MainScreenButton(
                            title: 'medicine',
                            imagePath: 'images/medicine.png',
                            widget: CategorizedMedicineScreen()),
                        MainScreenButton(
                          title: 'Med Equipment',
                          imagePath: 'images/medical_equipments.png',
                          widget: MedicalEquipmentsScreen(),
                        ),
                        MainScreenButton(
                          title: 'Cosmetics',
                          imagePath: 'images/cosmetics.png',
                          widget: CosmaticsScreen(),
                        ),

                        ///if the logged in person is pharmaceutical
                        ElevatedButton(
                            onPressed: () {
                              navigateTo(
                                  context, const MedicinesManagementScreen());
                            },
                            child: const Text('medicine management')),
                        ElevatedButton(
                            onPressed: () {
                              navigateTo(context, const AddNewEquipment());
                            },
                            child: const Text('add new product')),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text('requeset med')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
