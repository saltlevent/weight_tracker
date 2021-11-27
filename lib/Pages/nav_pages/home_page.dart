import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/models/record.dart';

import '../../controller_getx.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() => Container(padding: EdgeInsets.symmetric(vertical: 150,horizontal: 10), child: LineChart(flChartData())));
  }

  LineChartData flChartData(){
    final ControllerGetx _controller = Get.find();
    _controller.reloadRecords();

    int maxWeight = 0;
    int minWeight = 200;

    List<FlSpot> flSpotList = [];
    for(var item in _controller.records){
        flSpotList.add(FlSpot(item.dateTime.day.toDouble(), item.weight.toDouble()));

        if(item.weight >= maxWeight){
          maxWeight = item.weight;
        }
        if(item.weight <= minWeight){
          minWeight = item.weight;
        }
    }

    return LineChartData(
        minX: 0,
        maxX: 30,
        minY: (minWeight - 5).toDouble(),
        maxY: (maxWeight + 5).toDouble(),
        backgroundColor: Colors.blue[50],
        axisTitleData: FlAxisTitleData(
            bottomTitle: AxisTitle(titleText: "Days",margin: 20, showTitle: true),
            leftTitle: AxisTitle(titleText: "Weights", showTitle: true),
            show: true,
        ),

        lineBarsData: [
          LineChartBarData(
              spots: flSpotList
          )
        ]
    );
  }

  Widget weightHistory(){
    return Container();
  }

  Widget weightGraph(){
    return Container();
  }
}
