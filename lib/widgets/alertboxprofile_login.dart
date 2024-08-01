import 'package:flutter/material.dart';
import 'package:trip_plannerx/screens/loginscreen.dart';

class Logout{
  final BuildContext context;

  Logout({required this.context});

  void showLogoutConfirmation(Future<void> Function() onLogoutConfirmed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel logout
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await onLogoutConfirmed(); // Perform async action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
