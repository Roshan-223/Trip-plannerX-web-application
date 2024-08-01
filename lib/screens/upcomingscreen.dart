import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:trip_plannerx/model/schedule_db.dart';
import 'package:trip_plannerx/widgets/alertboxprofile_edit_schedulepage.dart';

double? splitAmount;

class Upcoming extends StatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  Box<Schedule>? scheduleBox;
  Box<Schedule>? completedBox;
  List<Schedule> upcomingTrips = [];
  final Map<int, TextEditingController> _controllers =
      {}; // Unique controllers for TextField

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    scheduleBox = await Hive.openBox<Schedule>('addtrip');
    completedBox = await Hive.openBox<Schedule>('completedtrips');
    if (scheduleBox != null && completedBox != null) {
      separateTrips(); 
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             if (upcomingTrips.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'No upcoming trips',
                    
                  ),
                ),
              )
              else
            Expanded(
              child: ListView.builder(
                itemCount: upcomingTrips.length,
                itemBuilder: (context, index) {
            
                  final schedule = upcomingTrips[index];
                
                  if (!_controllers.containsKey(index)) {
                    _controllers[index] = TextEditingController(
                      text: "",
                    );
                  }
                  return Card(
                    elevation: 5,
                    color: const Color.fromARGB(255, 248, 243, 243),
                    // color:Colors.white,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            'Destination: ${schedule.destination}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8,),
                           const Text(
                            'Companions :',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,fontSize: 15
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: schedule.companion
                                  .map(
                                    (companionName) => Text(
                                      companionName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,fontSize: 13),
                                    ),
                                  )
                                  .toList()),
                          const SizedBox(height: 7),
                          Text(
                            'Start Date: ${DateFormat("EEEE, MMMM d, yyyy").format(schedule.startDate)}',
                            style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 14),
                          ),
                          Text(
                            'End Date: ${DateFormat("EEEE, MMMM d, yyyy").format(schedule.endDate)}',
                            style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 160,
                            child: TextField(
                              controller:
                                  _controllers[index], // Unique controller
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Enter estimate amount",
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  fontSize: 13, // Smaller font size
                                ),
                              onChanged: (value) {
                                double totalAmount = double.tryParse(value) ?? 0;
                                int numberOfCompanions =
                                    schedule.companion.length;
                                double splitAmount =
                                    totalAmount / numberOfCompanions;
                                setState(() {
                                  schedule.splitAmount = splitAmount;
                                });
                          
                                scheduleBox!.putAt(
                                  index,
                                  Schedule(
                                    companion: schedule.companion,
                                    destination: schedule.destination,
                                    startDate: schedule.startDate,
                                    endDate: schedule.endDate,
                                    splitAmount: splitAmount, 
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Splitted amount: ${schedule.splitAmount != null ? schedule.splitAmount.toString() : 'None'}',
                            style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 13),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      trailing: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              EditScheduleDialog(
                                context: context,
                                scheduleBox: scheduleBox!,
                                index: index,
                                schedule: schedule,
                                onSave: () {
                                  setState(() {}); 
                                },
                              ).showEditDialog();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Deletion'),
                                    content: const Text(
                                        'Are you sure you want to delete this schedule?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          scheduleBox!.deleteAt(index);
                                          separateTrips();
                                          setState(() {}); //
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    
  }
 void separateTrips() {
    if (scheduleBox == null) return;

    upcomingTrips.clear();

    final now = DateTime.now();
  
    for (int i = scheduleBox!.length - 1; i >= 0; i--) {
      final schedule = scheduleBox!.getAt(i);

      if (schedule != null) {
        if (schedule.endDate.isBefore(now)) {
          completedBox?.add(schedule);
          scheduleBox!.deleteAt(i);
        } else {
          upcomingTrips.add(schedule);
          // Move to completed box if end date has passed
           // Remove from upcoming
        }
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    scheduleBox?.close();
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}
