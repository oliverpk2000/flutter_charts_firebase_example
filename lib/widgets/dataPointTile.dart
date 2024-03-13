import 'package:flutter/material.dart';
import 'package:flutter_charts_firebase_example/domain/DataPoint.dart';

class DataPointTile extends StatefulWidget {
  final DataPoint dataPoint;

  final String dataPointId;

  const DataPointTile(
      {super.key, required this.dataPoint, required this.dataPointId});

  @override
  State<DataPointTile> createState() => _DataPointTileState();
}

class _DataPointTileState extends State<DataPointTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${widget.dataPoint.amount}"),
      subtitle: Text("${widget.dataPointId} ${widget.dataPoint.timestamp}"),
    );
  }
}
