import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/controller_getx.dart';
import 'package:weight_tracker/models/record.dart';

class WeightListileComponent extends StatelessWidget {
  const WeightListileComponent({Key? key, required this.record}) : super(key: key);

  final Record record;

  @override
  Widget build(BuildContext context) {

    final ControllerGetx _controller = Get.find();
    return Card(
      child: ListTile(
        title: Center(child: Text("${record.weight.toString()} Kg")),
        leading: Text(DateFormat("MMMM d, hh:mm").format(record.dateTime)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
            IconButton(onPressed: () => _controller.deleteRecord(record), icon: const Icon(Icons.delete), splashColor: Colors.red, color: Colors.red,)
          ],
        ),
      )
    );
  }
}
