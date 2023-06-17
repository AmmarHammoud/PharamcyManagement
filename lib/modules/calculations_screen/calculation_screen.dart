import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  late DateTime minDate, maxDate;
  late List<SalesData> salesData;
  @override
  void initState() {
    minDate = DateTime(2020, 1, 1);
    maxDate = DateTime(2020, 1, 7);
    salesData = randomSalesValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

class SalesData {
  SalesData(this.day, this.sales);

  final DateTime day;
  //final String DateString;
  final double sales;
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