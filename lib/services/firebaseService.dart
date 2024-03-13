import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/DataPoint.dart';

class FirebaseService {
  String path = "https://fl-charts-example-default-rtdb.firebaseio.com";

  postDataPoint(DataPoint dataPoint) async {
    var url = Uri.parse("$path.json");
    try {
      var response = await http.post(
        url,
        body: json.encode(dataPoint.toJson()),
      );
      if (response.statusCode == 200) {
      } else {
        throw "Something went wrong while posting datapoint: ${dataPoint.toJson()}";
      }
    } catch (error) {
      throw "Error while creating: $error";
    }
  }

  Future<Map<String, DataPoint>> getAllDataPoints() async {
    var url = Uri.parse("$path.json");
    Map<String, DataPoint> dataPointMap = {};
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        jsonMap.forEach((key, value) {
          //TODO: could be fucked.
          DateTime timestamp = DateTime.parse(value["timestamp"]);
          int amount = int.parse(value["amount"]);
          DataPoint dataPoint = DataPoint(timestamp: timestamp, amount: amount);
          dataPointMap[key] = dataPoint;
        });
      } else {
        throw "Something went wrong while getting all data points";
      }
    } catch (error) {
      throw "Error while creating: $error";
    }
    return dataPointMap;
  }
}
