class DataPoint {
  DateTime timestamp = DateTime.now();
  int amount = 0;

  DataPoint({required this.timestamp, required this.amount});

  DataPoint.newDataPoint(this.amount) {
    timestamp = DateTime.now();
  }

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(
        timestamp: DateTime.parse(json["timestamp"]), amount: json["amount"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "timestamp": timestamp.toString(),
      "amount": amount,
    };
  }
}
