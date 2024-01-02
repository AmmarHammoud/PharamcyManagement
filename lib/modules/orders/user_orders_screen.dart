import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dac/modules/orders/cubit/cubit.dart';
import 'package:dac/modules/orders/cubit/states.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrdersScreen extends StatelessWidget {
  const UserOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..getUserOrders(),
      child: BlocConsumer<OrdersCubit, OrdersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var userOrders = OrdersCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: ConditionalBuilder(
                  condition: state is! OrdersLoadingState,
                  builder: (context) => ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return OrderViewer(
                        orderId: userOrders.userOrders[index].orderId,
                          userName: userOrders.userOrders[index].userName,
                          medName: userOrders.userOrders[index].medName,
                          userId: userOrders.userOrders[index].userId.toString(),
                          status: userOrders.userOrders[index].status,
                          payment: userOrders.userOrders[index].payment.toString(),
                          quantity: userOrders.userOrders[index].quantity,
                          imagePath: 'images/medicine.png',
                          condition: 1 == 1,
                          onPressed: (){});
                    },
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20,),
                    itemCount: userOrders.userOrders.length,
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  )),
            );
          }),
    );
  }
}
