import 'package:dac/modules/calculations_screen/cubit/states.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../calculation_screen.dart';

class CalculationCubit extends Cubit<CalculationsStates> {
  CalculationCubit() : super(CalculationInitialState());

  static CalculationCubit get(context) => BlocProvider.of(context);
  List<SalesData> salesData = [];

  getWeekly() {
    DioHelper.getWeeklyEarning(token: CashHelper.getUserToken()!).then((value) {
      //print(value.data['data']);
      value.data['data'].forEach(
        (k, v) => salesData.add(SalesData(DateTime.parse(k), v)),
      );
      //value.data['data'].forEach((k, v) => print('k: $k, v: $v'));
      //var x = DateTime.parse('2023-07-24 00:00:00');
      //print(DateFormat('yyyy/MM/dd').format(x));
      print(salesData[0].sales);
    }).catchError((error) {});
  }
}
