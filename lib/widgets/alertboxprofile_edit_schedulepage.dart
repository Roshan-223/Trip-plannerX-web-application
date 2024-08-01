import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_plannerx/model/schedule_db.dart';
import 'package:hive/hive.dart';

class EditScheduleDialog {
  final BuildContext context;
  final Box<Schedule> scheduleBox;
  final Schedule schedule;
  final int index;
  final Function() onSave; // Callback function when "Save" is clicked

  late TextEditingController destinationController;
  late TextEditingController companionController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  EditScheduleDialog({
    required this.context,
    required this.scheduleBox,
    required this.schedule,
    required this.index,
    required this.onSave,
  }) {
     destinationController =
        TextEditingController(text: schedule.destination);
    companionController =
        TextEditingController(text: schedule.companion.join(', '));
    startDateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(schedule.startDate));
    endDateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(schedule.endDate));

  }

  void showEditDialog() {
   DateTime startDate=schedule.startDate;
   DateTime endDate =schedule.endDate;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Schedule"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: destinationController,
                decoration: const InputDecoration(
                  labelText: "Destination",
                  hintText: "Enter new destination",
                ),
              ),
              TextField(
                controller: companionController,
                decoration: const InputDecoration(
                  labelText: "Companions",
                  hintText: "Enter companions (comma-separated)",
                ),
              ),
              TextField(
                controller: startDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Start Date",
                ),
                onTap: () {
                  selectDate(context, startDate, (pickedDate) {
                    startDate = pickedDate;
                    startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                },
              ),
             TextField(
                controller: endDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "End Date",
                ),
                onTap: () {
                  selectDate(context, endDate, (pickedDate) {
                    endDate = pickedDate;
                    endDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Save the changes in Hive
                schedule.destination = destinationController.text;
                schedule.companion = companionController.text.split(", ");
                schedule.startDate = startDate;
                schedule.endDate = endDate;
                scheduleBox.putAt(index, schedule); 

                onSave(); 
                Navigator.of(context).pop(); 
              },
              child: const Text("Save"),
              
            ),
            
          ],
        
        );
      
      },
      
    );
  }
  

  Future<void> selectDate(BuildContext context, DateTime initialDate, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }
}
