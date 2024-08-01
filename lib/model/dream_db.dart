import 'package:hive/hive.dart';

 part 'dream_db.g.dart';

@HiveType(typeId: 4) 
class Dream {
  @HiveField(0)
  final String name; 
  
  @HiveField(1)
  double totalExpense; 
  
  @HiveField(2)
  double savings; 
  
  Dream({
    required this.name,
    required this.totalExpense,
    required this.savings,
  });
}