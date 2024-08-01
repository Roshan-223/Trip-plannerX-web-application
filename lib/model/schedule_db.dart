import 'package:hive_flutter/adapters.dart';
part 'schedule_db.g.dart';
@HiveType(typeId: 2)
class Schedule {
@HiveField(0)
 late List<String> companion;
 @HiveField(1)
  String destination;
  @HiveField(2)
  DateTime startDate;
  @HiveField(3)
  DateTime endDate;
  @HiveField(4)
  double? splitAmount;
  Schedule({required this.companion,required this.destination, required this.startDate, required this.endDate,required this.splitAmount,});
  
  get contactname => null;
}