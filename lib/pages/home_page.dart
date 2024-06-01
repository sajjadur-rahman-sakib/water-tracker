import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sakib/pages/helper/water_consume.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController =
      TextEditingController(text: '1');
  List<WaterConsume> waterConsumeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Traker"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              _buildWaterConsumeButton(),
              const SizedBox(
                height: 24,
              ),
              _buildNumberOfGlassTextField(),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "History",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Total: ${_totalWaterCount()}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
              _buildWaterTrackListView()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberOfGlassTextField() {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: _textEditingController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          labelText: "No of Glass",
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        ),
      ),
    );
  }

  Widget _buildWaterConsumeButton() {
    return GestureDetector(
      onDoubleTap: _addWater,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.amber, width: 8),
        ),
        child: const Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                Icon(
                  Icons.water_drop_outlined,
                  size: 35,
                ),
                Text("Tap Here")
              ],
            )),
      ),
    );
  }

  Widget _buildWaterTrackListView() {
    return Expanded(
        child: ListView.builder(
            itemCount: waterConsumeList.length,
            itemBuilder: (context, index) {
              return _buildSingleListItem(waterConsumeList[index], index + 1);
            }));
  }

  Widget _buildSingleListItem(WaterConsume waterConsume, int serial) {
    return ListTile(
      title: Text(DateFormat.yMEd().add_jms().format(waterConsume.time)),
      leading: CircleAvatar(
        child: Text("$serial"),
      ),
      trailing: Text(
        waterConsume.glassCount.toString(),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  void _addWater() {
    int glassCount = int.tryParse(_textEditingController.text) ?? 1;
    WaterConsume waterConsume =
        WaterConsume(time: DateTime.now(), glassCount: glassCount);
    waterConsumeList.add(waterConsume);
    setState(() {});
  }

  int _totalWaterCount() {
    int totalWaterCount = 0;
    for (WaterConsume waterConsume in waterConsumeList) {
      totalWaterCount += waterConsume.glassCount;
    }
    return totalWaterCount;
  }
}
