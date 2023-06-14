import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class CalculationScreen extends StatelessWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
                height: 250,
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Calculations'),
                    primaryXAxis: CategoryAxis(),
                    series: <LineSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                          dataSource:  <SalesData>[
                            SalesData('Sun', 2),
                            SalesData('Mon', 5),
                            SalesData('Tue', 1),
                            SalesData('Wed', 7),
                            SalesData('Thu', 5),
                            SalesData('Fri', 6),
                            SalesData('Sat', 10),
                          ],
                          xValueMapper: (SalesData sales, _) => sales.day,
                          yValueMapper: (SalesData sales, _) => sales.sales
                      )
                    ]
                )
            )
        )
    );
  }
}

class SalesData {
  SalesData(this.day, this.sales);
  final String day;
  final double sales;
}