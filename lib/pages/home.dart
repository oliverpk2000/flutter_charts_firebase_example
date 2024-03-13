import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_charts_firebase_example/pages/lineChartPage.dart';
import 'package:flutter_charts_firebase_example/services/firebaseService.dart';
import 'package:flutter_charts_firebase_example/widgets/dataPointTile.dart';
import 'package:provider/provider.dart';

import '../domain/DataPoint.dart';
import '../providers/DataProvider.dart';
import 'barChartPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var textController = TextEditingController(text: "0");

  late Map<String, DataPoint> dataPointMap = {};

  Timer? timer;

  @override
  void initState() {
    super.initState();
    loadData();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      loadData();
      print("timer");
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.dataPointMap = dataPointMap;
    return Scaffold(
      appBar: AppBar(
        title: const Text("FL Charts Demo"),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 600,
            child: TextFormField(
              controller: textController,
              keyboardType: TextInputType.number,
            ),
          ),
          TextButton(
              onPressed: () {
                int amount = int.parse(textController.text);
                dataProvider.postDataPointFromAmount(amount);
                textController.clear();
              },
              child: const Text("submit")),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LineChartPage()));
              },
              child: const Text("go to line chart")),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BarChartPage()));
              },
              child: const Text("go to bar chart")),
          Expanded(
            child: ListView.builder(
                itemCount: dataProvider.dataPointMap.length,
                itemBuilder: (context, index) {
                  DataPoint dataPoint =
                      dataProvider.dataPointMap.entries.elementAt(index).value;
                  String dataPointId =
                      dataProvider.dataPointMap.entries.elementAt(index).key;
                  return DataPointTile(
                      dataPoint: dataPoint, dataPointId: dataPointId);
                }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  loadData() async {
    var reloadedData = await FirebaseService().getAllDataPoints();
    setState(() {
      dataPointMap = reloadedData;
    });
  }
}
