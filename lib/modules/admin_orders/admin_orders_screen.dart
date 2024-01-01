import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dac/modules/admin_orders/cubit/cubit.dart';
import 'package:dac/modules/admin_orders/cubit/states.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminOrdersCubit()..getAdminOrders(),
      child: BlocConsumer<AdminOrdersCubit, AdminOrdersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var ordersCubit = AdminOrdersCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ConditionalBuilder(
                          condition: state is! AdminOrdersLoadingState,
                          builder: (context) => ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return AdminOrderViewer(
                                      status:
                                          ordersCubit.adminOrders[index].status,
                                      quantity: ordersCubit
                                          .adminOrders[index].quantity,
                                      payment: ordersCubit
                                          .adminOrders[index].payment
                                          .toString(),
                                      medName: ordersCubit
                                          .adminOrders[index].medId
                                          .toString(),
                                      userId: ordersCubit
                                          .adminOrders[index].userId
                                          .toString(),
                                      imagePath: 'images/medicine.png',
                                      condition: 1 == 1,
                                      onPressed: () {});
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  height: 20,
                                ),
                                itemCount: ordersCubit.adminOrders.length,
                              ),
                          fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              )),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
