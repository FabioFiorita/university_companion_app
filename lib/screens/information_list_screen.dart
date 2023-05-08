import 'package:c317_mobile/exceptions/contact_exception.dart';
import 'package:c317_mobile/exceptions/teacher_exception.dart';
import 'package:c317_mobile/providers/teacher_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/error_message.dart';
import '../components/information_card.dart';
import '../models/contact.dart';
import '../models/teacher.dart';
import '../providers/contact_provider.dart';

class InformationListScreen extends StatelessWidget {
  final String title;
  final String listLabel;
  final bool isTeacherList;

  const InformationListScreen(
      {Key? key,
      required this.title,
      required this.listLabel,
      required this.isTeacherList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              listLabel,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            (isTeacherList)
                ? Expanded(
                    child: Consumer<TeacherProvider>(
                      builder: (_, store, __) {
                        final teachers = store.teachers;
                        if (teachers.isEmpty) {
                          return _handleError(TeacherException.teacherNotFound);
                        }
                        return _teacherList(teachers);
                      },
                    ),
                  )
                : Expanded(
                    child: Consumer<ContactProvider>(
                      builder: (_, store, __) {
                        final contacts = store.contacts;
                        if (contacts.isEmpty) {
                          return _handleError(ContactException.contactNotFound);
                        }
                        return _contactList(contacts);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _teacherList(List<Teacher> teachers) {
    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        return InformationCard(
          title: teachers[index].name,
          subtitle: teachers[index].email,
        );
      },
    );
  }

  Widget _contactList(List<Contact> contacts) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return InformationCard(
          title: contacts[index].area,
          subtitle: contacts[index].number,
        );
      },
    );
  }

  Widget _handleError(Object? error) {
    if (error is ContactException) {
      return ErrorMessage(
        title: error.title,
        message: error.message,
      );
    } else if (error is TeacherException) {
      return ErrorMessage(
        title: error.title,
        message: error.message,
      );
    } else {
      return const ErrorMessage();
    }
  }
}
