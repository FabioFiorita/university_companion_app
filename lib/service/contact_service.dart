import 'dart:convert';

import 'package:c317_mobile/exceptions/contact_exception.dart';
import 'package:c317_mobile/utils/response_handler.dart';
import 'package:http/http.dart' as http;

import '../http/web_client.dart';
import '../models/contact.dart';

class ContactService {
  http.Client client = WebClient().client;

  Future<List<Contact>> getContacts() async {
    try {
      http.Response response = await client
          .get(
            Uri.parse("${WebClient.baseUrl}contacts"),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, ContactException.contactNotFound);
      }

      return saveInfoFromResponse(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Contact>> saveInfoFromResponse(String body) async {
    final List<Contact> contacts = jsonDecode(body)
        .map<Contact>((contact) => Contact.fromJson(contact))
        .toList();

    return contacts;
  }
}
