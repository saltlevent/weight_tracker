import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/components/weight_listile_component.dart';
import 'package:weight_tracker/controller_getx.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/services/firebase_database.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final ControllerGetx _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Record> _records = _controller.records;

    FirebaseDatabase().getRecordsFromDatabase();

    _controller.reloadRecords();

    return Obx(() => _records.isEmpty
        ? const Center(child: Text("Please add record"))
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _records.length,
            itemBuilder: (context, index) {
              return WeightListileComponent(record: _records[index]);
            },
          ));
  }
}
