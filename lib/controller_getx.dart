import 'dart:convert';

import 'package:get/get.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/services/firebase_database.dart';

class ControllerGetx extends GetxController{

  var records = <Record>[

  ].obs;

  void addRecord(Record record){
    records.add(record);
    //print(records.length);
    FirebaseDatabase().addToDatabase(records);
    reloadRecords();
  }

  void deleteRecord(Record record){
    records.remove(record);
    FirebaseDatabase().addToDatabase(records);
    reloadRecords();
  }

  Future reloadRecords() async{
    FirebaseDatabase().getRecordsFromDatabase().then((value){
      var json = jsonDecode(value) as List;
      List<Record> objs = json.map((recs) => Record.fromJson(recs)).toList();
      records.clear();
      records.addAll(objs);
    });
  }
}