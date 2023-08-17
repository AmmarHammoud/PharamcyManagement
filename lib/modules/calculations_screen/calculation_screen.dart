import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.day, this.sales);

  late DateTime day;
  late double sales;

  @override
  String toString() {
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

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
    List<SalesData> salesData = randomSalesValues();
    DateTime minDate = DateTime(2020, 1, 1);
    DateTime maxDate = DateTime(2020, 1, 7);
  @override
  Widget build(BuildContext context) {
    //var calc = CalculationCubit.get(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: const Text('Calculations')),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SfCartesianChart(
                    primaryYAxis: NumericAxis(
                      //anchorRangeToVisiblePoints: true,
                        isVisible: true),
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
                        setState(() {
                          minDate = minDate.subtract(const Duration(days: 7));
                          maxDate = maxDate.subtract(const Duration(days: 7));
                        });
                        //zoomBehavior.panToDirection('left');
                      },
                      icon: const Icon(Icons.keyboard_arrow_left),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          minDate = minDate.add(const Duration(days: 7));
                          maxDate = maxDate.add(const Duration(days: 7));
                        });
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
  }
}
