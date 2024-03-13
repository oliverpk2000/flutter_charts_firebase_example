import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/DataProvider.dart';

class LineChartPage extends StatefulWidget {
  const LineChartPage({super.key});

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("line chart"),
      ),
      body: AspectRatio(
          aspectRatio: 2,
          child: LineChart(
            LineChartData(lineBarsData: [
              LineChartBarData(
                  isCurved: false, spots: dataProvider.getFlSpots())
            ]),
          )),
    );
  }
}
