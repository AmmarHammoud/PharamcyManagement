import 'package:dac/modules/add_new_product/add_new_medication/add_new_medication_screen.dart';
import 'package:dac/modules/admin_orders/admin_orders_screen.dart';
import 'package:dac/modules/medicines_management/get_total_medicines_screee.dart';
import 'package:dac/shared/components.dart';
import 'package:dac/shared/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../../shared/cash_helper.dart';
import '../categories/categories.dart';
import '../medicines_management/medicines_management.dart';
import '../search_box/search_box.dart';

class HomeScreen extends StatelessWidget {
  bool isAdmin = CashHelper.isAdmin();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(CashHelper.getUserPhone());
    // if(CashHelper.getUserToken() != null){
    //NotificationService notificationService=NotificationService();
    //notificationService.initialise();
    // }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            const TranslateButton(),
            IconButton(
                onPressed: () {
                  navigateTo(context, const AdminOrdersScreen());
                },
                icon: const Icon(Icons.notification_important_outlined)),
            if (!isAdmin) const WhatsappButton(),
          ],
        ),
        drawer: MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: divisor,
                ),
                const SearchBox(),
                const SizedBox(
                  height: divisor,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: [
                    MainScreenButton(
                        title: AppLocal.categories.getString(context),
                        widget: CategorizedMedicineScreen(),
                        imagePath: 'images/medicine.png'),
                    //MainScreenButton(title: 'add', widget: AddNewMedicationScreen(), imagePath: 'images/medicine.png'),
                    MainScreenButton(
                        title: AppLocal.medicines.getString(context),
                        imagePath: 'images/medicine.png',
                        widget: GetTotalMedicinesScreen()),
                    // MainScreenButton(
                    //   title: 'Med Equipment',
                    //   imagePath: 'images/medical_equipments.png',
                    //   widget: MedicalEquipmentsScreen(),
                    // ),
                    // MainScreenButton(
                    //   title: 'Cosmetics',
                    //   imagePath: 'images/cosmetics.png',
                    //   widget: CosmaticsScreen(),
                    // ),
                    // ///if the logged in person is pharmaceutical
                    // if(isAdmin)ElevatedButton(
                    //     onPressed: () {
                    //       navigateTo(
                    //           context, const MedicinesManagementScreen());
                    //     },
                    //     child: const Text('medicine management')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
