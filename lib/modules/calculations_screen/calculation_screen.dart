import 'dart:math';
import 'package:dac/modules/calculations_screen/cubit/cubit.dart';
import 'package:dac/modules/calculations_screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.day, this.sales);
  late DateTime day;
  late double sales;
  @override
  String toString(){
    return 'day: $day, sales: $sales';
  }
}

List<SalesData> randomSalesValues() {
  List<SalesData> list = [];
  DateTime initialDate = DateTime(2020, 1, 1);
  for (int i = 1; i <= 21; i++) {
    list.add(SalesData(initialDate, Random().nextInt(100000) + 10000));
    initialDate = initialDate.add(const Duration(days: 1));
  }
  return list;
}

class CalculationScreen extends StatelessWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CalculationCubit()..getWeekly(), child: BlocConsumer<CalculationCubit, CalculationsStates>(
      listener: (context, state){},
      builder: (context, state){
        var calc = CalculationCubit.get(context);
        late DateTime minDate, maxDate;
        List<SalesData> salesData = calc.salesData;
        minDate = DateTime(2023, 7, 24);
        maxDate = DateTime(2023, 8, 7);
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(),
              body:  Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SfCartesianChart(
                        primaryYAxis:
                        NumericAxis(anchorRangeToVisiblePoints: true, isVisible: true),
                        primaryXAxis: DateTimeAxis(
                          minimum: minDate,
                          maximum: maxDate,
                          interval: 1,
                        ),
                        series: <ChartSeries<SalesData, DateTime>>[
                          ColumnSeries<SalesData, DateTime>(
                            dataSource: salesData,
                            xValueMapper: (SalesData sales, _) => sales.day,
                            yValueMapper: (SalesData sales, _) => sales.sales,
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // setState(() {
                            //   minDate = minDate.subtract(const Duration(days: 7));
                            //   maxDate = maxDate.subtract(const Duration(days: 7));
                            // });
                            //zoomBehavior.panToDirection('left');
                          },
                          icon: const Icon(Icons.keyboard_arrow_left),
                        ),
                        IconButton(
                          onPressed: () {
                            // setState(() {
                            //   minDate = minDate.add(const Duration(days: 7));
                            //   maxDate = maxDate.add(const Duration(days: 7));
                            // });
                            //zoomBehavior.panToDirection('right');
                          },
                          icon: const Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    ),);
  }
}
