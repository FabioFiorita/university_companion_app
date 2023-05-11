import 'package:flutter/cupertino.dart';

import '../exceptions/contact_exception.dart';
import '../models/contact.dart';
import '../service/contact_service.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  ContactProvider() {
    getContacts();
  }

  Future<void> getContacts() async {
    _isLoading = true;
    notifyListeners();
    if (_contacts.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    final ContactService contactService = ContactService();
    try {
      final List<Contact> contacts = await contactService.getContacts();
      _isLoading = false;
      if (contacts.isEmpty) {
        throw ContactException.contactNotFound;
      }
      _contacts = contacts;
      notifyListeners();
    } catch (e) {
      _error = e;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cleanCache() async {
    _contacts = [];
    await getContacts();
  }
}
