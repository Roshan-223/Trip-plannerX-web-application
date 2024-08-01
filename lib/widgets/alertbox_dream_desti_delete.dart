import 'package:flutter/material.dart';

class DeleteDreamDialog {
  static void showDelete(BuildContext context, VoidCallback onDelete) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Dream Destination"),
            content: const Text(
                "Are you sure you want to delete this dream destination?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
                child: const Text("Delete"),
              ),
            ],
          );
        });
  }
}
