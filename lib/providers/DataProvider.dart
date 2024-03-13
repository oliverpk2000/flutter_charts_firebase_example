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
    notifyListeners();
  }

  postDataPointFromAmount(int amount){
    postDataPoint(DataPoint.newDataPoint(amount));
  }
}
