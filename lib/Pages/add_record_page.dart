import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:horizontal_center_date_picker/date_item.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weight_tracker/controller_getx.dart';
import 'package:weight_tracker/models/record.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {

  final ControllerGetx _controller = Get.find();

  final TextEditingController _noteController = TextEditingController();

  final DatePickerController _dateController = DatePickerController();

  int _weight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildWeightSelector(),
              buildDatePicker(context),
              buildNoteTextField(),
              Expanded(child: Container()),
              TextButton(
                child: const Text("ADD", style: TextStyle(color: Colors.white, fontSize: 30)),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff6470b3),
                    padding: const EdgeInsets.all(15),
                ),
                onPressed: onSubmit,
              ),
              TextButton(
                child: const Text("CANCEL", style: TextStyle(color: Colors.white, fontSize: 20)),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffb36464),
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: onCancel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit(){
                  _controller.addRecord(Record(weight: _weight, dateTime: _dateController.selectedDate!, note: _noteController.text));
                  Get.back();
                  Get.snackbar(
                      "Record",
                      "Record is succesfully added",
                      animationDuration: const Duration(seconds: 1),
                      snackPosition: SnackPosition.BOTTOM,
                      onTap: (value) => Get.back());
                }


  void onCancel(){
    Get.back();
  }

  Container buildWeightSelector() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          const Text("Select Your Weight"),
          NumberPicker(
            minValue: 10,
            maxValue: 300,
            axis: Axis.horizontal,
            value: _weight,
            onChanged: (value) => setState(() => _weight = value),
            selectedTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
            textStyle: const TextStyle(fontSize: 12, color: Colors.black54),
            infiniteLoop: true,
          ),
        ],
      ),
    );
  }

  Container buildDatePicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          const Text("Select Date"),
          HorizontalDatePickerWidget(
            startDate: DateTime(2021),
            endDate: DateTime.now(),
            dateItemComponentList: const [DateItem.Month,DateItem.Day],
            selectedDate: DateTime.now(),
            widgetWidth: MediaQuery. of(context). size. width,
            datePickerController: _dateController,
            dayFontSize: 20,
            selectedColor: Colors.black12,
            selectedTextColor: Colors.black,
            normalTextColor: Colors.black38,
            normalColor: Colors.black12,
            weekDayFontSize: 10,
          ),
        ],
      ),
    );
  }

  Container buildNoteTextField() {
    return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: _noteController,
                onSubmitted: (value) => onSubmit(),
                decoration: const InputDecoration(border: InputBorder.none, hintText: "Type some notes...",labelText: "Your Note"),
              ),
            );
  }

}
