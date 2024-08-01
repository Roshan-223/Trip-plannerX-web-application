import 'package:flutter/material.dart';

class AddSavings{
static void showAddSavingsDialog(BuildContext context, Function(double) onAddSavings, double remainingExpense) {
    double amount = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Savings Amount"),
          content: TextField(
            controller: TextEditingController(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter Amount",
            ),
            onChanged: (value) {
              amount = double.tryParse(value) ?? 0;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (amount <= remainingExpense) {
                  onAddSavings(amount);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("The entered amount exceeds the remaining expense."),
                    ),
                  );
                }
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
  }
}