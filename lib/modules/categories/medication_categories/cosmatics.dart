import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';

import '../../search_box/search_box.dart';
class CosmaticsScreen extends StatelessWidget {
  var searchController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cosmatics',
        ),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SearchBox(),
              const SizedBox(
                height: 15.0,
              ),
               //AddNewProductButton(condition: 0 == 1, onPressed: (){},),
            ],
          ),
        ),
      ),
    );
  }
}
