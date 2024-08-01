import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_plannerx/model/dream_db.dart';
import 'package:trip_plannerx/widgets/alertbox_dream_addsavings.dart';
import 'package:trip_plannerx/widgets/alertbox_dream_desti_delete.dart';
import 'package:trip_plannerx/widgets/alertbox_dream_edit.dart';

class DreamDestination extends StatefulWidget {
  const DreamDestination({Key? key}) : super(key: key);

  @override
  _DreamDestinationState createState() => _DreamDestinationState();
}

class _DreamDestinationState extends State<DreamDestination> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _savingsController = TextEditingController();

  late Box<Dream> _dreamBox;
  List<Dream> _dreamDestinations = [];

  @override
  void initState() {
    super.initState();
    _openBoxAndLoadData();
  }

  Future<void> _openBoxAndLoadData() async {
    _dreamBox = await Hive.openBox<Dream>('dream_destinations');
    _loadDreamDestinations();
  }

  void _loadDreamDestinations() {
    _dreamDestinations = _dreamBox.values.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dream Destinations"),
      ),
      body: _dreamDestinations.isEmpty
          ? const Center(child: Text("No dream destinations added yet"))
          : ListView.builder(
              itemCount: _dreamDestinations.length,
              itemBuilder: (context, index) {
                final Dream destination = _dreamDestinations[index];

                return Card(
                  child: ListTile(
                    title: Text(
                      'Destination: ${destination.name}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text("Total Expense: ${destination.totalExpense}"),
                        Text("Total Savings: ${destination.savings}"),
                        const SizedBox(
                          height: 8,
                        ),
                        LinearProgressIndicator(
                          value: destination.savings >= destination.totalExpense
                              ? 1.0 // Set progress to 1.0 if savings exceed or equal to total expense
                              : destination.savings / destination.totalExpense,
                          backgroundColor: Colors.grey[300],
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _addSavingsAmount(index);
                            },
                            child: const Text('Add savings amount')),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _editTotalExpense(index),
                          icon: const Icon(Icons.edit),
                        ),
                         IconButton(
                          onPressed: (){
                            DeleteDreamDialog.showDelete(context, () {
                              _deleteDreamDestination(index);
                             });
                          },
                          icon: const Icon(Icons.delete,color: Colors.red,),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Dream Destination"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Destination Name",
                      ),
                    ),
                    TextField(
                      controller: _expenseController,
                      decoration: const InputDecoration(
                        labelText: "Total Expense",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: _savingsController,
                      decoration: const InputDecoration(
                        labelText: "Total Savings",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      _addDreamDestination();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addDreamDestination() {
    final String name = _nameController.text.trim();
    final double totalExpense = double.tryParse(_expenseController.text) ?? 0;
    final double savings = double.tryParse(_savingsController.text) ?? 0;

    if (name.isNotEmpty && totalExpense >= 0) {
      var newDestination = Dream(
        name: name,
        totalExpense: totalExpense,
        savings: savings,
      );

      _dreamBox.add(newDestination);

      _nameController.clear();
      _expenseController.clear();
      _savingsController.clear();

      _loadDreamDestinations();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid name and total expense."),
        ),
      );
    }
  }

  void _editTotalExpense(int index) {
    final Dream destination = _dreamDestinations[index];
    _expenseController.text = destination.totalExpense.toString();

    EditExpense.showEditTotalExpenseDialog(
        context, _expenseController, destination, () {
      _dreamBox.putAt(index, destination);
      _loadDreamDestinations();
    }, () {
      Navigator.of(context).pop();
    });
  }

  void _addSavingsAmount(int index) {
    final Dream destination = _dreamDestinations[index];
    final double remainingExpense =
        destination.totalExpense - destination.savings;

    if (remainingExpense <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Total savings have reached or exceeded the total expense."),
        ),
      );
      return;
    }

    AddSavings.showAddSavingsDialog(
        context, (amount) => _addSavings(index, amount), remainingExpense);
  }

  void _addSavings(int index, double amount) {
    final Dream destination = _dreamDestinations[index];
    final double newSavings = destination.savings + amount;

    _dreamBox.putAt(
        index,
        Dream(
          name: destination.name,
          totalExpense: destination.totalExpense,
          savings: newSavings,
        ));
    _loadDreamDestinations();
  }

  void _deleteDreamDestination(int index) {
    _dreamBox.deleteAt(index);
    _loadDreamDestinations();
  }
}
