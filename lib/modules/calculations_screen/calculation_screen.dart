import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: const Column(
            children: [
              WeeklyEarnings(),
              SizedBox(
                height: 5,
              ),
              Pagination(),
            ],
          )),
    );
  }
}

class WeeklyEarnings extends StatefulWidget {
  const WeeklyEarnings({Key? key}) : super(key: key);

  @override
  State<WeeklyEarnings> createState() => _WeeklyEarningsState();
}

class _WeeklyEarningsState extends State<WeeklyEarnings> {
  late DateTime minDate, maxDate;
  late List<SalesData> salesData;

  @override
  void initState() {
    minDate = DateTime(2020, 1, 1);
    maxDate = DateTime(2020, 1, 7);
    // salesData = <SalesData>[
    //   SalesData(DateTime(2020, 1, 1), 32000),
    //   SalesData(DateTime(2020, 1, 2), 30000),
    //   SalesData(DateTime(2020, 1, 3), 50000),
    //   SalesData(DateTime(2020, 1, 4), 75000),
    //   SalesData(DateTime(2020, 1, 5), 63000),
    //   SalesData(DateTime(2020, 1, 6), 60000),
    //   SalesData(DateTime(2020, 1, 7), 55000),
    //   SalesData(DateTime(2020, 1, 8), 16000),
    //   SalesData(DateTime(2020, 1, 9), 35000),
    //   SalesData(DateTime(2020, 1, 10), 55000),
    //   SalesData(DateTime(2020, 1, 11), 45000),
    //   SalesData(DateTime(2020, 1, 12), 33000),
    //   SalesData(DateTime(2020, 1, 13), 40000),
    //   SalesData(DateTime(2020, 1, 14), 56000),
    //   SalesData(DateTime(2020, 1, 15), 37000),
    //   SalesData(DateTime(2020, 1, 16), 36000),
    //   SalesData(DateTime(2020, 1, 17), 80000),
    //   SalesData(DateTime(2020, 1, 18), 75000),
    //   SalesData(DateTime(2020, 1, 19), 43000),
    //   SalesData(DateTime(2020, 1, 20), 65000),
    //   SalesData(DateTime(2020, 1, 21), 51000),
    // ];
    salesData = randomSalesValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfCartesianChart(
            //enableAxisAnimation: true,
            primaryYAxis:
                NumericAxis(anchorRangeToVisiblePoints: true, isVisible: true),
            primaryXAxis: DateTimeAxis(
              // title: AxisTitle(text: 'Dates'),
              // axisLabelFormatter: (AxisLabelRenderDetails details) {
              //   if (details.axis.name == 'Dates') {
              //     for (final SalesData sampleData in salesData) {
              //       if (sampleData.xValue == details.text) {
              //         return ChartAxisLabel(sampleData.x, details.textStyle);
              //       }
              //     }
              //   }
              //   return ChartAxisLabel(details.text, details.textStyle);
              // },
              minimum: minDate,
              maximum: maxDate,
              interval: 1,
              //edgeLabelPlacement: EdgeLabelPlacement.shift
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

class Pagination extends StatefulWidget {
  const Pagination({Key? key}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  late double _visibleMin;
  late double _visibleMax;
  late List<ChartSampleData> chartData;

  @override
  void initState() {
    _visibleMin = 0;
    _visibleMax = 5;
    chartData = randomChartValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 350,
        child: Column(children: <Widget>[
          Expanded(child: Column(
            children: [
              _buildCartesianChart(),
              Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _visibleMin = _visibleMin-5;
                        _visibleMax = _visibleMax-5;
                      });
                      //zoomBehavior.panToDirection('left');
                    },
                    icon: const Icon(Icons.keyboard_arrow_left),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _visibleMin = _visibleMin+5;
                        _visibleMax = _visibleMax+5;
                      });
                      //zoomBehavior.panToDirection('right');
                    },
                    icon: const Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ],
          )),
        ]));
  }

  SfCartesianChart _buildCartesianChart() {
    return SfCartesianChart(
      primaryYAxis: NumericAxis(

        //interval: 2,
        //minimum: 0,
        //maximum: 26,
        isVisible: true,
        anchorRangeToVisiblePoints: true,
        //majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      primaryXAxis: CategoryAxis(
        visibleMaximum: _visibleMax,
        visibleMinimum: _visibleMin,
        interval: 1,
      ),
      series: getSeries(),
    );
  }

  List<ChartSeries<ChartSampleData, String>> getSeries() {
    return <ChartSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: chartData,

        // dataLabelSettings: const DataLabelSettings(
        //     isVisible: true, labelAlignment: ChartDataLabelAlignment.outer),

        xValueMapper: (ChartSampleData sales, _) => sales.xValue,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
      ),
    ];
  }
}

class ChartSampleData {
  final String xValue;
  final int y;

  ChartSampleData({required this.xValue, required this.y});
}

List<ChartSampleData> randomChartValues(){
  List<ChartSampleData> list = [];
  for(int i = 1 ; i <= 25; i++){
    list.add(ChartSampleData(xValue: '$i', y: Random().nextInt(40)+1));
  }
  return list;
}