import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {
  static Future<void> saveContacts(List<String> emails) async {
    if (await FlutterContacts.requestPermission()) {
      emails = emails.toSet().toList();

      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
        deduplicateProperties: true,
      );
      final List<String> contactsEmails = [];

      for (int i = 0; i < contacts.length; i++) {
        if (contacts[i].emails.isNotEmpty) {
          contactsEmails.addAll(
            contacts[i]
                .emails
                .map(
                  (email) => email.address,
                )
                .toList(),
          );
        }
      }

      for (final email in emails) {
        if (!contactsEmails.contains(email)) {
          final name = email.split('@')[0];
          final newContact = Contact(
            name: Name(first: name),
            emails: [Email(email)],
          );
          await newContact.insert();
        }
      }
    }
  }
}
