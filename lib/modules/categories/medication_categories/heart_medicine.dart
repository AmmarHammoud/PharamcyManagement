import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';

import '../../search_box/search_box.dart';

class HeartMedicine extends StatelessWidget {
  const HeartMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Heart medications',
        ),
      ),
      body: Column(
        children: [
          SearchBox(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
