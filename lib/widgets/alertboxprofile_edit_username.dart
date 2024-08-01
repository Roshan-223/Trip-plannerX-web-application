import 'package:flutter/material.dart';


class AlertProfile {
  final BuildContext context; 
  final TextEditingController nameController; 
  final ValueChanged<String> onNameChanged; // Callback to handle name changes

  AlertProfile({
    required this.context,
    required this.nameController,
    required this.onNameChanged,
  });

  
  void showEditNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit User Name"),
          content: TextField(
            controller: nameController, 
            decoration: const InputDecoration(hintText: "Enter new user name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final newUserName = nameController.text;
                onNameChanged(newUserName); // callback with the new name
                Navigator.of(context).pop(); 
                
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
