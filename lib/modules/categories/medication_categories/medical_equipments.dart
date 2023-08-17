import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';

import '../../search_box/search_box.dart';
class MedicalEquipmentsScreen extends StatelessWidget {
  final searchController = TextEditingController();

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
      body: const Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: const[
              SearchBox(),
              SizedBox(
                height: 15.0,
              ),
              // AddNewProductButton(condition: 0 == 1, onPressed: (){},),
            ],
          ),
        ),
      ),
    );
  }
}
