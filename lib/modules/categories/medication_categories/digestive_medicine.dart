import 'package:dac/modules/categories/medication_categories/cubit/cubit.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../search_box/search_box.dart';
import 'cubit/states.dart';

class DigestiveMedicine extends StatelessWidget {
  const DigestiveMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMedicineCategoriesCubit(),
      child:
          BlocConsumer<GetMedicineCategoriesCubit, GetMedicineCategoriesStates>(
              listener: (context, state) {},
              builder: (context, state) => Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: const Text(
                        'Digestive medications',
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
                  )),
    );
  }
}

/*
* Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title:
        const Text('Digestive medications',

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
* */
