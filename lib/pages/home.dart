import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/DataProvider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var textController = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("FL Charts Demo"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: textController,
          ),
          TextButton(
              onPressed: () {
                int amount = int.parse(textController.text);
                dataProvider.postDataPointFromAmount(amount);
              },
              child: const Text("submit")),
        ],
      ),
    );
  }
}
