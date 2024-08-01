import 'package:flutter/material.dart';

class EditExpense{
  static void showEditTotalExpenseDialog(BuildContext context, TextEditingController expenseController,destination, Function() onEdit, Function() onCancel) {
    expenseController.text = destination.totalExpense.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Total Expense"),
          content: TextField(
            controller: expenseController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "New Total Expense",
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final double? newExpense =
                    double.tryParse(expenseController.text);

                if (newExpense != null && newExpense >= 0) {
                  destination.totalExpense = newExpense;
                  onEdit();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter a valid expense."),
                    ),
                  );
                }
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: onCancel,
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

}