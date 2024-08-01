import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

List<Contact> selectedContacts = [];
List<String> selectedContactIds = [];

class ContactSelectionDialog extends StatefulWidget {
  const ContactSelectionDialog({super.key, required this.contacts});
  final List<Contact> contacts;

  @override
  ContactSelectionDialogState createState() => ContactSelectionDialogState();
}

class ContactSelectionDialogState extends State<ContactSelectionDialog> {
  List<String> tempSelectedContactIds = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select contacts'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: widget.contacts.length,
          itemBuilder: (BuildContext context, int index) {
            final contact = widget.contacts[index];
            final contactId = contact.identifier ?? '';

            return ListTile(
              title: Text(contact.displayName ?? ''),
              leading: Checkbox(
                activeColor: Colors.blue,
                checkColor: Colors.black,
                value: selectedContactIds.contains(contactId),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedContactIds.add(contactId);
                      selectedContacts.add(contact);
                    } else {
                      selectedContactIds.remove(contactId);
                      selectedContacts
                          .removeWhere((c) => c.identifier == contactId);
                    }

                    // print("Selected Contacts: $selectedContacts");
                  });
                },
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Ok'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              selectedContactIds.clear();
              selectedContactIds.addAll(tempSelectedContactIds);
            });
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
