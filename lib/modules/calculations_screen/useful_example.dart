import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Renders the pagination sample
class Pagination extends StatefulWidget {
  /// Creates the pagination chart
  const Pagination({Key? key}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  late double height, width, _segmentedControlWidth;
  late double _containerWidth, _containerHeight;
  double? diff;
  late int segmentedControlGroupValue;
  late int degree;
  late String day;
  late double _visibleMin;
  late double _visibleMax;
  late List<String> _daysWithTime;
  late List<String> _temperatue;
  late List<String> _days;
  late List<double> _minValues;
  late List<double> _maxValues;
  late List<int> _degrees;

  late List<ChartSampleData> chartData;

  @override
  void initState() {
    segmentedControlGroupValue = 0;
    degree = 25;
    day = 'Friday, 01:00 am';
    _visibleMin = 0;
    _visibleMax = 5;
    _daysWithTime = const <String>[
      'Friday, 01:00 am',
      'Saturday, 01:00 am',
      'Sunday, 01:00 am',
      'Monday, 01:00 am',
      'Tuesday, 01:00 am'
    ];
    _temperatue = const <String>[
      '25°19°',
      '25°20°',
      '24°18°',
      '19°14°',
      '18°14°'
    ];
    _days = const <String>['Fri', 'Sat', 'Sun', 'Mon', 'Tue'];
    _minValues = const <double>[0, 6, 12, 18, 24];
    _maxValues = const <double>[5, 11, 17, 23, 29];
    _degrees = const <int>[25, 25, 24, 19, 18];
    chartData = <ChartSampleData>[
      ChartSampleData(xValue: '0', x: '1 am', y: 20),
      ChartSampleData(xValue: '1', x: '4 am', y: 20),
      ChartSampleData(xValue: '2', x: '7 am', y: 20),
      ChartSampleData(xValue: '3', x: '10 am', y: 21),
      ChartSampleData(xValue: '4', x: '1 pm', y: 21),
      ChartSampleData(xValue: '5', x: '4 pm', y: 24),
      ChartSampleData(xValue: '6', x: '1 am', y: 19),
      ChartSampleData(xValue: '7', x: '4 am', y: 20),
      ChartSampleData(xValue: '8', x: '7 am', y: 20),
      ChartSampleData(xValue: '9', x: '10 am', y: 21),
      ChartSampleData(xValue: '10', x: '1 pm', y: 24),
      ChartSampleData(xValue: '11', x: '4 pm', y: 24),
      ChartSampleData(xValue: '12', x: '1 am', y: 21),
      ChartSampleData(xValue: '13', x: '4 am', y: 21),
      ChartSampleData(xValue: '14', x: '7 am', y: 21),
      ChartSampleData(xValue: '15', x: '10 am', y: 22),
      ChartSampleData(xValue: '16', x: '1 pm', y: 23),
      ChartSampleData(xValue: '17', x: '4 pm', y: 24),
      ChartSampleData(xValue: '18', x: '1 am', y: 20),
      ChartSampleData(xValue: '19', x: '4 am', y: 19),
      ChartSampleData(xValue: '20', x: '7 am', y: 19),
      ChartSampleData(xValue: '21', x: '10 am', y: 18),
      ChartSampleData(xValue: '22', x: '1 pm', y: 19),
      ChartSampleData(xValue: '23', x: '4 pm', y: 19),
      ChartSampleData(xValue: '24', x: '1 am', y: 16),
      ChartSampleData(xValue: '25', x: '4 am', y: 15),
      ChartSampleData(xValue: '26', x: '7 am', y: 14),
      ChartSampleData(xValue: '27', x: '10 am', y: 15),
      ChartSampleData(xValue: '28', x: '1 pm', y: 16),
      ChartSampleData(xValue: '29', x: '4 pm', y: 18),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;
    _segmentedControlWidth = width > 500 ? width * 0.5 : double.infinity;
    height = MediaQuery.of(context).size.height;
    height = height;
    height = height * 0.65;
    _containerHeight = 30;
    return SizedBox(
        height: 300,
        child: Column(children: <Widget>[
          Expanded(child: Container(child: _buildCartesianChart())),
          Visibility(
              visible: height < 350 ? false : true,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  width: _segmentedControlWidth,
                  child: CupertinoSlidingSegmentedControl<int>(
                      groupValue: segmentedControlGroupValue,
                      children: _getButtons(orientation),
                      onValueChanged: (int? i) => _loadGroupValue(i!))))
        ]));
  }

  /// Returns the item of segmented control
  Map<int, Widget> _getButtons(Orientation orientation) {
    _containerWidth = _segmentedControlWidth == double.infinity
        ? width / 5
        : _segmentedControlWidth / 5;
    const Color color = Colors.black;
    //const Color color = Color.fromRGBO(242, 242, 242, 1);
    final ButtonStyle style = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(getColor),
    );
    final Map<int, Widget> buttons = <int, Widget>{};
    for (int i = 0; i <= 4; i++) {
      buttons.putIfAbsent(
        i,
        () => SizedBox(
            width: _containerWidth,
            child: TextButton(
                onPressed: () => _loadGroupValue(i),
                style: style,
                child: Column(
                  children: <Widget>[
                    Text(_days[i],
                        style: TextStyle(fontSize: 12, color: color)),
                    Text(_temperatue[i],
                        style: TextStyle(fontSize: 12, color: color)),
                  ],
                ))),
      );
    }

    return buttons;
  }

  /// Returns color for the button based on interaction performed
  Color? getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return const Color.fromRGBO(104, 104, 104, 1);
    } else if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed)) {
      return const Color.fromRGBO(224, 224, 224, 1);
    } else {
      return null;
    }
  }

  /// Calls while performing the swipe operation
  void performSwipe(ChartSwipeDirection direction) {
    int? index;
    if (_visibleMin == 0 && _visibleMax == 5) {
      index = direction == ChartSwipeDirection.end ? 1 : null;
    } else if (_visibleMin == 6 && _visibleMax == 11) {
      index = direction == ChartSwipeDirection.end ? 2 : 0;
    } else if (_visibleMin == 12 && _visibleMax == 17) {
      index = direction == ChartSwipeDirection.end ? 3 : 1;
    } else if (_visibleMin == 18 && _visibleMax == 23) {
      index = direction == ChartSwipeDirection.end ? 4 : 2;
    } else if (_visibleMin == 24 && _visibleMax == 29) {
      index = direction == ChartSwipeDirection.end ? null : 3;
    }

    if (index != null) {
      _loadGroupValue(index);
    }
  }

  /// load the values based on the provided index
  void _loadGroupValue(int index) {
    setState(() {
      _visibleMin = _minValues[index];
      _visibleMax = _maxValues[index];
      segmentedControlGroupValue = index;
      degree = _degrees[index];
      day = _daysWithTime[index];
    });
  }

  /// Returns the cartesian chart
  SfCartesianChart _buildCartesianChart() {
    return SfCartesianChart(
      primaryYAxis: NumericAxis(
        interval: 2,
        minimum: 0,
        maximum: 26,
        isVisible: true,
        anchorRangeToVisiblePoints: true,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      primaryXAxis: CategoryAxis(
          visibleMaximum: _visibleMax,
          visibleMinimum: _visibleMin,
          labelPlacement: LabelPlacement.onTicks,
          interval: 1,
          name: 'primaryXAxis',
          axisLine: const AxisLine(width: 0, color: Colors.transparent),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: const MajorGridLines(width: 0),
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            if (details.axis.name == 'primaryXAxis') {
              for (final ChartSampleData sampleData in chartData) {
                if (sampleData.xValue == details.text) {
                  return ChartAxisLabel(sampleData.x, details.textStyle);
                }
              }
            }
            return ChartAxisLabel(details.text, details.textStyle);
          }),
      plotAreaBorderWidth: 0,
      series: getSeries(),
      onPlotAreaSwipe: (ChartSwipeDirection direction) =>
          performSwipe(direction),
    );
  }

  /// Returns the chart series
  List<ChartSeries<ChartSampleData, String>> getSeries() {
    return <ChartSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: chartData,
        borderColor: const Color.fromRGBO(255, 204, 5, 1),
        borderWidth: 2,
        color: const Color.fromRGBO(255, 245, 211, 1),
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.outer),
        xValueMapper: (ChartSampleData sales, _) => sales.xValue,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
      ),
    ];
  }
}

class ChartSampleData {
  final String xValue;
  final String x;
  final int y;

  ChartSampleData({
    required this.xValue,
    required this.x,
    required this.y,
  });
}
