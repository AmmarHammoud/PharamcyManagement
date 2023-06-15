import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  int index = 0;
  WeeklySales weeklySales = getData(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity! < 0) {
                    //Right swipe
                    setState(() {
                      if (index + 1 <= 2) {
                        weeklySales = getData(++index);
                      }
                    });
                  } else if (details.primaryVelocity! > 0) {
                    //left swipe
                    setState(() {
                      if (index - 1 >= 0) {
                        weeklySales = getData(--index);
                      }
                    });
                  }
                },
                child: WeeklyEarnings(
                  weeklySales: weeklySales,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class WeeklyEarnings extends StatelessWidget {
  final WeeklySales weeklySales;

  const WeeklyEarnings({Key? key, required this.weeklySales}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TrackballBehavior trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    return SfCartesianChart(
        enableAxisAnimation: true,
        //trackballBehavior: trackballBehavior,
        primaryYAxis: NumericAxis(
            minimum: weeklySales.min, maximum: weeklySales.max + 5000),
        title: ChartTitle(text: weeklySales.title),
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            markerSettings: const MarkerSettings(isVisible: true),
            dataSource: weeklySales.salesData,
            xValueMapper: (SalesData sales, _) => sales.day,
            yValueMapper: (SalesData sales, _) => sales.sales,
          ),
        ]);
  }
}

WeeklySales getData(int index) {
  var list = [
    WeeklySales(salesData: <SalesData>[
      SalesData('Sun', 32000),
      SalesData('Mon', 30000),
      SalesData('Tue', 50000),
      SalesData('Wed', 75000),
      SalesData('Thu', 63000),
      SalesData('Fri', 60000),
      SalesData('Sat', 55000),
    ], min: 30000, max: 75000, title: 'Week 1'),
    WeeklySales(salesData: <SalesData>[
      SalesData('Sun', 16000),
      SalesData('Mon', 35000),
      SalesData('Tue', 55000),
      SalesData('Wed', 45000),
      SalesData('Thu', 33000),
      SalesData('Fri', 40000),
      SalesData('Sat', 56000),
    ], min: 16000, max: 56000, title: 'Week 2'),
    WeeklySales(salesData: <SalesData>[
      SalesData('Sun', 37000),
      SalesData('Mon', 36000),
      SalesData('Tue', 80000),
      SalesData('Wed', 75000),
      SalesData('Thu', 43000),
      SalesData('Fri', 65000),
      SalesData('Sat', 51000),
    ], min: 36000, max: 80000, title: 'Week 3')
  ];
  return list[index];
}

class SalesData {
  SalesData(this.day, this.sales);

  final String day;
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
