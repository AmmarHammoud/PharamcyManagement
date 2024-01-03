import 'package:dac/modules/categories/medication_categories/cubit/cubit.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'medication_categories/cubit/states.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoryController = TextEditingController();
    var categoryValidator = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add category'),
      ),
      body: BlocProvider(
        create: (context) => GetMedicineCategoriesCubit(),
        child: BlocConsumer<GetMedicineCategoriesCubit,
            GetMedicineCategoriesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var addCategory = GetMedicineCategoriesCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ValidatedTextField(
                      controller: categoryController,
                      validator: categoryValidator,
                      errorText: 'category must be filled',
                      hintText: 'category',
                      onChanged: (String x) {}),
                  const SizedBox(height: 20,),
                  CustomizedButton(
                      title: 'Add category',
                      condition: state is! GetMedicineCategoriesLoadingState,
                      onPressed: () {
                        if(categoryValidator.currentState!.validate()) {
                          addCategory.addCategory(
                            context: context, title: categoryController.text);
                        }
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
/**/
