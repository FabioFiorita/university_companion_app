import 'package:c317_mobile/exceptions/contact_exception.dart';
import 'package:c317_mobile/exceptions/teacher_exception.dart';
import 'package:c317_mobile/providers/teacher_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/error_body.dart';
import '../components/information_card.dart';
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
    ContactProvider contactProvider =
        Provider.of<ContactProvider>(context, listen: false);
    TeacherProvider teacherProvider =
        Provider.of<TeacherProvider>(context, listen: false);
    const List<Widget> mockTeacherList = [
      InformationCard(
        title: 'Renzo Mesquita',
        subtitle: 'renzo@inatel.br',
      ),
      InformationCard(
        title: 'Chris Lima',
        subtitle: 'chris@inatel.br',
      ),
      InformationCard(
        title: 'Marcelo',
        subtitle: 'marcelo@inatel.br',
      ),
    ];
    const List<Widget> mockCollegePhones = [
      InformationCard(
        title: 'CRA',
        subtitle: '(35) 3921-3123',
      ),
      InformationCard(
        title: 'Tesouraria',
        subtitle: '(35) 3921-3124',
      ),
      InformationCard(
        title: 'RH',
        subtitle: '(35) 3921-3125',
      ),
    ];
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
            Expanded(
                child: FutureBuilder<void>(
              future: isTeacherList
                  ? teacherProvider.getTeachers()
                  : contactProvider.getContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return _handleError(snapshot.error);
                  }
                  return ListView.builder(
                    itemCount: isTeacherList
                        ? teacherProvider.teachers.length
                        : contactProvider.contacts.length,
                    itemBuilder: (context, index) {
                      return InformationCard(
                        title: isTeacherList
                            ? teacherProvider.teachers[index].name
                            : contactProvider.contacts[index].area,
                        subtitle: isTeacherList
                            ? teacherProvider.teachers[index].email
                            : contactProvider.contacts[index].number,
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget _handleError(Object? error) {
    if (error is ContactException) {
      return ErrorBody(
        title: error.title,
        message: error.message,
      );
    } else if (error is TeacherException) {
      return ErrorBody(
        title: error.title,
        message: error.message,
      );
    } else {
      return const ErrorBody();
    }
  }
}
