import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';

import '../../../shared/cash_helper.dart';
import '../../search_box/search_box.dart';
import 'package:dac/modules/add_new_product/add_new_medical_equipments/add_new_medical_equipments.dart';
class MedicalEquipmentsScreen extends StatelessWidget {
  final searchController = TextEditingController();
  bool isAdmin = CashHelper.isAdmin();
  MedicalEquipmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Med Equipment',
        ),
      ),
      drawer:  MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBox(),
              SizedBox(
                height: 15.0,
              ),
              if(isAdmin)ElevatedButton(
                  onPressed: () {
                    navigateTo(context, const AddNewEquipment());
                  },
                  child: const Text('add new product'))
            ],
          ),
        ),
      ),
    );
  }
}
