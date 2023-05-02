import 'dart:convert';

import 'package:c317_mobile/exceptions/contact_exception.dart';
import 'package:c317_mobile/exceptions/subject_exception.dart';
import 'package:c317_mobile/exceptions/user_exception.dart';
import 'package:c317_mobile/models/subject.dart';
import 'package:http/http.dart' as http;

import '../exceptions/general_exception.dart';
import '../http/web_client.dart';
import '../models/contact.dart';
import '../models/user.dart';

class ContactService {
  http.Client client = WebClient().client;

  Future<List<Contact>> getContacts(User user) async {
    try {
      http.Response response = await client
          .get(
            Uri.parse("${WebClient.baseUrl}users/${user.id}/contacts"),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        _handleStatusCode(response);
      }

      return saveInfoFromResponse(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Contact>> saveInfoFromResponse(String body) async {
    final List<Contact> contacts = json
        .decode(body)
        .map<Contact>((subject) => Contact.fromJson(subject))
        .toList();

    return contacts;
  }

  void _handleStatusCode(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // success
        break;
      case 400:
        throw GeneralException.undefined;
      case 404:
        throw ContactException.contactNotFound;
      case 429:
        throw GeneralException.tooManyRequests;
      default:
        throw GeneralException.undefined;
    }
  }
}
