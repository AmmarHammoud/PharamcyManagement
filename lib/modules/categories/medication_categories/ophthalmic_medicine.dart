import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';

import '../../search_box/search_box.dart';


class OphthalmicMedicine extends StatelessWidget {
  const OphthalmicMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Ophthalmic medications',
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
      drawer: const MyDrawer(),
    );
  }
}
