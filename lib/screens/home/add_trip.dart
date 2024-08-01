import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trip_plannerx/model/schedule_db.dart';
import 'package:trip_plannerx/screens/home/contact_alertbox.dart';
import 'package:trip_plannerx/screens/home/bottom_navigation_screens/bottom_schedule.dart';
import 'package:trip_plannerx/screens/upcomingscreen.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  final Set<DateTime> _selectedDates = {};

  CalendarFormat calendarFormat = CalendarFormat.month;
  final DateTime focusedDay = DateTime.now();
  List<DateTime> selectedDates = [];
  final List<Contact> contacts = [];
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  final TextEditingController _destinationController = TextEditingController();

  Future<List<Contact>> getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      return await ContactsService.getContacts();
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your trip'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _destinationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter your destination",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select companion from your contact',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                List<Contact> contacts = await getContacts();
                await showDialog(
                  context: context,
                  builder: (context) =>
                      ContactSelectionDialog(contacts: contacts),
                );
                setState(() {
                  selectedContacts.clear();
                  selectedContacts.addAll(contacts.where((contact) =>
                      selectedContactIds.contains(contact.identifier)));
                });
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(100, 30)),
              ),
              child: const Text('Select'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selected companions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: selectedContacts.length,
              itemBuilder: (BuildContext context, int index) {
                final contact = selectedContacts[index];
                return ListTile(
                  title: Text(contact.displayName ?? ''),
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Schedule your trip',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            TableCalendar(
              focusedDay: focusedDay,
              calendarFormat: calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  calendarFormat = format;
                });
              },
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              onPageChanged: (focusedDay) {
                focusedDay = focusedDay;
              },
              selectedDayPredicate: (day) {
                return _selectedDates.contains(day);
              },
              rowHeight: 40,
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (selectedStartDate == null) {
                    selectedStartDate = selectedDay;
                    selectedEndDate = null;
                    _selectedDates.clear();
                    _selectedDates.add(selectedDay);
                  } else if (selectedEndDate == null &&
                      selectedDay.isAfter(selectedStartDate!)) {
                    selectedEndDate = selectedDay;
                    _selectedDates.add(selectedDay);
                  } else {
                    selectedStartDate = selectedDay;
                    selectedEndDate = null;
                    _selectedDates.clear();
                    _selectedDates.add(selectedDay);
                  }
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Start Date: ${selectedStartDate != null ? dateFormat.format(selectedStartDate!) : 'None'}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'End Date: ${selectedEndDate != null ? dateFormat.format(selectedEndDate!) : 'None'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                      if (_destinationController.text.isNotEmpty) {
      List<String> selectedContactNames = selectedContacts
          .map((contact) => contact.displayName ?? '')
          .toList();

                      var hbox = await Hive.openBox<Schedule>('addtrip');
                      hbox.add(Schedule(
                        companion: selectedContactNames.isNotEmpty? selectedContactNames:[],
                        destination: _destinationController.text,
                        startDate: selectedStartDate!,
                        endDate: selectedEndDate!,
                        splitAmount: splitAmount,
                      ));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleListPage(),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Missing Information'),
                            content: const Text(
                                'Please enter destination and select at least one companion.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Schedule trip'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
