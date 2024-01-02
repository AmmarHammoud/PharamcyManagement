import 'package:dac/modules/orders/cubit/states.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dac/models/admin_order_model.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);

  List<AdminOrdersModel> adminOrders = [];
  List<AdminOrdersModel> userOrders = [];

  getAdminOrders() {
    emit(OrdersLoadingState());
    DioHelper.getAdminOrders().then((value) {
      print(value.data);

      for (int i = 0; i < value.data['data'].length; i++) {
        adminOrders.add(AdminOrdersModel.fromJson(value.data['data'][i]));
      }
      emit(OrdersSuccessState());
    }).onError((error, stack) {
      print(error.toString());
      emit(OrdersErrorState());
    });
  }

  getUserOrders() {
    emit(OrdersLoadingState());
    DioHelper.getUserOrders(userId: CashHelper.getUserId()).then((value) {
      print(value.data);
      for (int i = 0; i < value.data['data'].length; i++) {
        userOrders.add(AdminOrdersModel.fromJson(value.data['data'][i]));
      }
      print('user orders length: ${userOrders.length}');
      emit(OrdersSuccessState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(OrdersErrorState());
    });
  }
}
