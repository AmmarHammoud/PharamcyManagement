import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'useful_example.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              WeeklyEarnings(),
              SizedBox(height: 25,),
              Pagination(),
            ],
          )),
    );
  }
}

class WeeklyEarnings extends StatelessWidget {
  const WeeklyEarnings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ZoomPanBehavior zoomBehavior =
        ZoomPanBehavior(enablePinching: true, enableSelectionZooming: true);
    return Column(
      children: [
        SfCartesianChart(
            zoomPanBehavior: zoomBehavior,
            onZooming: (ZoomPanArgs z) {
              //print(z.currentZoomPosition);
            },
            onPlotAreaSwipe: (ChartSwipeDirection direction){print(direction);},
            enableAxisAnimation: true,
            //trackballBehavior: trackballBehavior,
            primaryYAxis: NumericAxis(minimum: 10000, maximum: 100000),
            title: ChartTitle(text: 'title'),
            primaryXAxis: DateTimeAxis(),
            series: <ColumnSeries<SalesData, DateTime>>[
              ColumnSeries<SalesData, DateTime>(
                //markerSettings: const MarkerSettings(isVisible: true),
                dataSource: <SalesData>[
                  SalesData(DateTime(2020, 1, 1), 32000),
                  SalesData(DateTime(2020, 1, 2), 30000),
                  SalesData(DateTime(2020, 1, 3), 50000),
                  SalesData(DateTime(2020, 1, 4), 75000),
                  SalesData(DateTime(2020, 1, 5), 63000),
                  SalesData(DateTime(2020, 1, 6), 60000),
                  SalesData(DateTime(2020, 1, 7), 55000),
                  SalesData(DateTime(2020, 1, 8), 16000),
                  SalesData(DateTime(2020, 1, 9), 35000),
                  SalesData(DateTime(2020, 1, 10), 55000),
                  SalesData(DateTime(2020, 1, 11), 45000),
                  SalesData(DateTime(2020, 1, 12), 33000),
                  SalesData(DateTime(2020, 1, 13), 40000),
                  SalesData(DateTime(2020, 1, 14), 56000),
                  SalesData(DateTime(2020, 1, 15), 37000),
                  SalesData(DateTime(2020, 1, 16), 36000),
                  SalesData(DateTime(2020, 1, 17), 80000),
                  SalesData(DateTime(2020, 1, 18), 75000),
                  SalesData(DateTime(2020, 1, 19), 43000),
                  SalesData(DateTime(2020, 1, 20), 65000),
                  SalesData(DateTime(2020, 1, 21), 51000),
                ],
                xValueMapper: (SalesData sales, _) => sales.day,
                yValueMapper: (SalesData sales, _) => sales.sales,
              ),
            ]),
        Row(
          children: [
            IconButton(
              onPressed: () {
                zoomBehavior.zoomIn();
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                zoomBehavior.zoomOut();
              },
              icon: const Icon(Icons.remove),
            ),
            IconButton(
              onPressed: () {
                zoomBehavior.panToDirection('top');
              },
              icon: const Icon(Icons.arrow_upward),
            ),
            IconButton(
              onPressed: () {
                zoomBehavior.panToDirection('bottom');
              },
              icon: const Icon(Icons.arrow_downward),
            ),
            IconButton(
              onPressed: () {
                zoomBehavior.panToDirection('left');
              },
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            IconButton(
              onPressed: () {
                zoomBehavior.panToDirection('right');
              },
              icon: const Icon(Icons.keyboard_arrow_right),
            ),
            IconButton(
              onPressed: () {
                zoomBehavior.reset();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        )
      ],
    );
  }
}

class SalesData {
  SalesData(this.day, this.sales);

  final DateTime day;
  final double sales;
}

class WeeklySales {
  final List<SalesData> salesData;
  final double min;
  final double max;
  final String title;

  WeeklySales(
      {required this.salesData,
      required this.min,
      required this.max,
      required this.title});
}
