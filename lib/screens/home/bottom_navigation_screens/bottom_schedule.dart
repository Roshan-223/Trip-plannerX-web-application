import 'package:flutter/material.dart';
import 'package:trip_plannerx/screens/completepage.dart';
import 'package:trip_plannerx/screens/upcomingscreen.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({Key? key}) : super(key: key);

  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedules '),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text('Upcoming'),
            ),
            Tab(
              child: Text('Completed'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Upcoming(),
          CompletePage(),
        ],
      ),
    );
  }
}
