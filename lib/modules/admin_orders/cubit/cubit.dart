import 'package:dac/modules/admin_orders/cubit/states.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dac/models/admin_order_model.dart';

class AdminOrdersCubit extends Cubit<AdminOrdersStates> {
  AdminOrdersCubit() : super(AdminOrdersInitialState());

  static AdminOrdersCubit get(context) => BlocProvider.of(context);

  List<AdminOrdersModel> adminOrders = [];

  getAdminOrders() {
    emit(AdminOrdersLoadingState());
    DioHelper.getAdminOrders().then((value) {
      print(value.data);
      for (int i = 0; i < value.data['data'].length; i++) {
        adminOrders.add(AdminOrdersModel.fromJson(value.data['data'][i]));
      }
      emit(AdminOrdersSuccessState());
    }).onError((error, stack) {
      print(error.toString());
      emit(AdminOrdersErrorState());
    });
  }
}
