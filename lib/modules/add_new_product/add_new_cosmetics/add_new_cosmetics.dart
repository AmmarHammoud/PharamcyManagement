import 'package:dac/modules/add_new_product/add_new_cosmetics/cubit/cubit.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class AddNewCosmetics extends StatelessWidget {
  AddNewCosmetics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewCosmeticCubit(),
      child: BlocConsumer<AddNewCosmeticCubit, AddNewCosmeticsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final addNewCosmetics = AddNewCosmeticCubit.get(context);
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'New Equipment',
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "please enter ^_^ :",
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        ValidatedTextField(
                            controller: addNewCosmetics.name,
                            icon: Icons.drive_file_rename_outline,
                            validator: addNewCosmetics.nameValidator,
                            errorText: 'name field must be filled',
                            hintText: 'name',
                            onChanged: (name) {}),
                        const SizedBox(
                          height: 25.0,
                        ),
                        ValidatedTextField(
                            controller: addNewCosmetics.price,
                            icon: Icons.price_change,
                            validator: addNewCosmetics.priceValidator,
                            errorText: 'price filed must be filled',
                            hintText: 'price',
                            onChanged: (price) {}),
                        const SizedBox(
                          height: 25.0,
                        ),
                        ValidatedTextField(
                            controller: addNewCosmetics.quantity,
                            icon:
                                Icons.production_quantity_limits_rounded,
                            validator: addNewCosmetics.quantityValidator,
                            errorText: 'quantity field must be filled',
                            hintText: 'quantity',
                            onChanged: (quantity) {}),
                        const SizedBox(
                          height: 25.0,
                        ),
                        ValidatedTextField(
                            controller: addNewCosmetics.description,
                            icon: Icons.description_outlined,
                            validator: addNewCosmetics.descriptionValidator,
                            errorText: 'description field must be filled',
                            hintText: 'description',
                            onChanged: (description) {}),
                        const SizedBox(
                          height: 25.0,
                        ),
                        CustomizedButton(
                            title: 'add new cosmetics',
                            condition: state is! AddNewCosmeticsLoadingState,
                            onPressed: () {})
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
