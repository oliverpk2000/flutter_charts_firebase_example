import 'dart:js_util';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_charts_firebase_example/services/firebaseService.dart';

import '../domain/DataPoint.dart';

class DataProvider with ChangeNotifier {
  Map<String, DataPoint> dataPointMap = {};

  getDataPoints() async {
    dataPointMap = await FirebaseService().getAllDataPoints();
    notifyListeners();
  }

  postDataPoint(DataPoint dataPoint) async {
    await FirebaseService().postDataPoint(dataPoint);
  }

  postDataPointFromAmount(int amount) {
    postDataPoint(DataPoint.newDataPoint(amount));
    notifyListeners();
  }

  List<FlSpot> getFlSpots() {
    return getDailyData()
        .values
        .map((e) => FlSpot(
            (e.timestamp.difference(getLastMidnight()).inMinutes * 1.0),
            e.amount * 1.0))
        .toList();
  }

  DateTime getLastMidnight() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  Map<String, DataPoint> getDailyData() {
    Map<String, DataPoint> map = {};
    dataPointMap.forEach((key, value) {
      if (value.timestamp.isAfter(getLastMidnight())) {
        map[key] = value;
      }
    });
    return map;
  }

  List<BarChartGroupData> getBarChartData() {
    List<BarChartGroupData> barChartData = [];
    var daily = sumDailyAmountsByHour();
    for (var data in daily.entries) {
      var bar = BarChartGroupData(
          x: data.key, barRods: [BarChartRodData(toY: (data.value * 1.0))]);
      barChartData.add(bar);
    }
    return barChartData;
  }

  Map<int, int> sumDailyAmountsByHour() {
    Map<int, int> dailySum = {};
    var daily = getDailyData();
    for (var data in daily.entries) {
      if (dailySum.containsKey(data.value.timestamp.hour)) {
        var amount = dailySum[data.value.timestamp.hour]!;
        amount = amount + data.value.amount;
        dailySum[data.value.timestamp.hour] = amount;
      } else {
        dailySum[data.value.timestamp.hour] = data.value.amount;
      }
    }
    return dailySum;
  }
}
