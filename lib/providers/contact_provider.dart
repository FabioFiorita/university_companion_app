import 'package:flutter/cupertino.dart';

import '../exceptions/contact_exception.dart';
import '../models/contact.dart';
import '../service/contact_service.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> getContacts() async {
    final ContactService contactService = ContactService();
    try {
      final List<Contact> contacts = await contactService.getContacts();
      if (contacts.isEmpty) {
        throw ContactException.contactNotFound;
      }
      _contacts = contacts;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
